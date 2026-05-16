import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../data/models/cart/cart_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/cart/cart_cubit.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/empty_widget.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loading_widget.dart';
import 'component/cart_component.dart';
import 'component/collapsed_component.dart';
import 'component/panel_component.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<CartCubit>().getCartProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final loginBloc = context.read<LoginBloc>();

    return Scaffold(
      backgroundColor: homeBgColor.withOpacity(0.99),
      body: BlocConsumer<CartCubit, LanguageCodeState>(
        listener: (context, state) {
          final cart = state.cartState;
          if (cart is CartError) {
            if (cart.statusCode == 503 || cartCubit.cartModel == null) {
              cartCubit.getCartProduct();
            } else if (cart.statusCode == 401) {
              loginBloc.add(const LoginEventLogout());
            } else {
              Utils.errorSnackBar(context, cart.message);
            }
          }
        },
        builder: (context, state) {
          final cart = state.cartState;
          if (cart is CartLoading) {
            return const LoadingWidget();
          } else if (cart is CartError) {
            if (cart.statusCode == 503 || cartCubit.cartModel != null) {
              return CartLoadedWidget(cartModel: cartCubit.cartModel!);
            } else {
              return FetchErrorText(text: cart.message);
            }
          } else if (cart is CartLoaded) {
            return CartLoadedWidget(cartModel: cart.cartModel);
          }
          if (cartCubit.cartModel != null) {
            return CartLoadedWidget(cartModel: cartCubit.cartModel!);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

class CartLoadedWidget extends StatefulWidget {
  const CartLoadedWidget({super.key, required this.cartModel});

  final CartModel cartModel;

  @override
  State<CartLoadedWidget> createState() => _CartLoadedWidgetState();
}

class _CartLoadedWidgetState extends State<CartLoadedWidget> {
  final controller = PanelController();

  double height = 120.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final product = widget.cartModel;
    if (widget.cartModel.cartItems!.isNotEmpty) {
      return SlidingUpPanel(
        body: Column(
          children: [
            Padding(
              padding: Utils.symmetric(v: 50.0).copyWith(bottom: 10.0),
              child: const CustomAppBar(
                title: 'Cart Product',
                isGradientBg: true,
                iconColor: whiteColor,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: Utils.only(bottom: size.height * 0.14),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: product.cartItems!.length,
                itemBuilder: (context, index) {
                  final item = product.cartItems![index];
                  return CartComponent(theme: item);
                },
              ),
            ),
            Utils.verticalSpace(20.0),
          ],
        ),
        panelBuilder: (con) => PanelComponent(
            panelController: controller, cartModel: widget.cartModel),
        collapsed:
            CollapsedComponent(panelController: controller, height: height),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Utils.radius(20.0)),
            topRight: Radius.circular(Utils.radius(20.0))),
        controller: controller,
        minHeight: Utils.vSize(height),
        maxHeight: Utils.vSize(380.0),
        defaultPanelState: PanelState.CLOSED,
        panelSnapping: false,
        backdropEnabled: true,
        backdropTapClosesPanel: false,
        parallaxEnabled: true,
        backdropOpacity: 0.4,
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 36,
            offset: Offset(0, 0),
            spreadRadius: 5,
          )
        ],
      );
    } else {
      return Center(
        child: EmptyWidget(
          icon: KImages.emptyWishlist,
          text: 'No cart item found!',
          isSliver: false,
        ),
      );
    }
  }
}

class SlidingTopWidget extends StatelessWidget {
  const SlidingTopWidget({super.key, this.margin = 20.0});

  final double margin;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: Utils.vSize(4.0),
        width: Utils.vSize(60.0),
        margin: Utils.symmetric(v: margin),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: Utils.borderRadius()),
      ),
    );
  }
}

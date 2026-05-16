import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../data/models/cart/cart_model.dart';
import '../../../../data/models/cart/coupon_model.dart';
import '../../../../logic/cubit/add_to_cart/add_to_cart_cubit.dart';
import '../../../../logic/cubit/language_code_state.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/primary_button.dart';
import '../cart_screen.dart';

class PanelComponent extends StatefulWidget {
  const PanelComponent(
      {super.key, required this.panelController, required this.cartModel});

  final PanelController panelController;
  final CartModel cartModel;

  @override
  State<PanelComponent> createState() => _PanelComponentState();
}

class _PanelComponentState extends State<PanelComponent> {
  double subtotal = 0.0;
  double total = 0.0;
  int discount = 0;
  final textController = TextEditingController();
  CouponDto? couponDto;

  @override
  void initState() {
    loadCalculation();
    super.initState();
  }

  loadCalculation() {
    for (var i = 0; i < widget.cartModel.cartItems!.length; i++) {
      if (widget.cartModel.cartItems![i].variant != null) {
        subtotal += double.parse(
            widget.cartModel.cartItems![i].variant!.price.toString());
      } else {
        subtotal += widget.cartModel.cartItems![i].product!.regularPrice;
      }
    }
    total += subtotal;

    couponDto = context.read<AddToCartCubit>().couponDto;
    if (couponDto != null) {
      _refreshCartCalculation(couponDto!);
    }
    print("check coupon $couponDto");
  }

  void _refreshCartCalculation(CouponDto value) {
    couponDto = value;
    total = subtotal - (value.discount / 100 * subtotal);
    discount = value.discount;

    if (mounted) setState(() {});
  }

  void _removeCoupon() {
    context.read<AddToCartCubit>().removeCoupon();
    if (couponDto != null) {
      couponDto = null;
      total = subtotal;
      discount = 0;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddToCartCubit>();
    return BlocListener<AddToCartCubit, LanguageCodeState>(
      listener: (context, state) {
        final addToCart = state.addToCartState;
        if (addToCart is ApplyStateLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (addToCart is ApplyStateError) {
            Utils.errorSnackBar(context, addToCart.message);
          } else if (addToCart is CouponDataLoaded) {
            Utils.showSnackBar(context, addToCart.couponDto.message);
            _refreshCartCalculation(addToCart.couponDto);
          }
        }
      },
      child: Container(
        padding: Utils.symmetric(v: 0.0).copyWith(bottom: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SlidingTopWidget(),
            // const CustomText(text: 'Apply Promo Code', fontSize: 16.0),
            // Utils.verticalSpace(8.0),
            if (couponDto == null) ...[
              TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Apply Coupon Code',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: Utils.borderRadius(r: 4.0),
                      borderSide: const BorderSide(color: Color(0xFFDBDBDB))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: Utils.borderRadius(r: 4.0),
                      borderSide: const BorderSide(color: Color(0xFFDBDBDB))),
                  border: OutlineInputBorder(
                      borderRadius: Utils.borderRadius(r: 4.0),
                      borderSide: const BorderSide(color: Color(0xFFDBDBDB))),
                  hintStyle: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: blackColor,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      final map = {'coupon_name': textController.text};
                      cubit.applyCoupon(map);
                      textController.clear();
                    },
                    child: Container(
                      margin: Utils.all(value: 4.0),
                      padding: Utils.symmetric(v: 12.0),
                      //alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: Utils.borderRadius(r: 6.0),
                      ),
                      child: const CustomText(
                        text: 'Apply',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: blackColor,
                ),
              ),
            ],

            if (couponDto != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: "Remove Coupon",
                      fontSize: 20.0,
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                    Utils.horizontalSpace(6),
                    GestureDetector(
                      onTap: () => _removeCoupon(),
                      child: Padding(
                        padding: Utils.only(top: 4.0),
                        child: const Icon(Icons.clear, color: redColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Utils.verticalSpace(30.0),
            const CustomText(
              text: 'Bill Details',
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
            ),
            Utils.verticalSpace(10.0),
            _priceWidget('Subtotal', Utils.formatPrice(context, subtotal)),
            Utils.verticalSpace(10.0),
            _priceWidget(
                'Discount', Utils.formatPrice(context, discount), redColor),
            Container(
              margin: Utils.symmetric(h: 0.0, v: 10.0),
              height: 1.0,
              color: borderColor2,
            ),
            _priceWidget('Order Amount', Utils.formatPrice(context, total),
                blackColor, 20.0),
            Utils.verticalSpace(14.0),
            PrimaryButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.paymentScreen),
              text: 'Processed to Checkout',
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceWidget(String title, String price,
      [Color textColor = blackColor, double fontSize = 16.0]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontSize: fontSize,
          color: textColor,
        ),
        CustomText(
          text: price,
          fontSize: fontSize,
          color: textColor,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/wishlist/wishlist_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/bloc/login/login_state_model.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/empty_widget.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';
import 'wishlist_component.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key, required this.isVisibleBackButton});

  final bool isVisibleBackButton;

  @override
  Widget build(BuildContext context) {
    final wishlistCubit = context.read<WishlistCubit>();
    final loginBloc = context.read<LoginBloc>();
    wishlistCubit.getWistItems();
    return Scaffold(
      backgroundColor: isVisibleBackButton ? scaffoldBgColor : homeBgColor,
      body: BlocListener<LoginBloc, LoginStateModel>(
        listener: (context, state) {
          final logout = state.loginState;
          if (logout is LoginStateLogoutLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (logout is LoginStateLogoutError) {
              Utils.errorSnackBar(context, logout.message);
            } else if (logout is LoginStateLogoutLoaded) {
              Utils.showSnackBar(context, logout.message);
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.authenticationScreen, (route) => false);
            }
          }
        },
        child: BlocConsumer<WishlistCubit, LanguageCodeState>(
          listener: (context, state) {
            final wishlist = state.wishlistState;
            if (wishlist is WishlistShowError) {
              if (wishlist.statusCode == 401) {
                loginBloc.add(const LoginEventLogout());
              } else {
                Utils.errorSnackBar(context, wishlist.message);
              }
            }
          },
          builder: (context, state) {
            final wishlist = state.wishlistState;
            if (wishlist is WishlistLoading) {
              return const Center(child: LoaderCircle());
             // return const LoadingWidget();
            } else if (wishlist is WishlistShowError) {
              if (wishlist.statusCode == 503) {
                if (wishlistCubit.wishList.isNotEmpty) {
                  return LoadedWishlistItem(wishlist: wishlistCubit.wishList);
                } else {
                  return const FetchErrorText(text: 'Network problem');
                }
              }
              return FetchErrorText(text: wishlist.message);
            } else if (wishlist is WishlistLoaded) {
              return LoadedWishlistItem(wishlist: wishlist.wishListData);
            }
            if (wishlistCubit.wishList.isNotEmpty) {
              return LoadedWishlistItem(wishlist: wishlistCubit.wishList);
            } else {
              return const FetchErrorText(text: 'Something went wrong!');
            }
          },
        ),
      ),
    );
  }
}

class LoadedWishlistItem extends StatelessWidget {
  const LoadedWishlistItem({super.key, required this.wishlist});

  final List<WishlistModel> wishlist;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const CustomSliverAppBar(
          title: 'Wishlist',
          isShowBackButton: false,
          // isShowBackButton: isVisibleBackButton ? true : false,
        ),
        wishlist.isNotEmpty
            ? SliverList.list(
                children: List.generate(
                  wishlist.length,
                  (index) {
                    final list = wishlist[index];
                    return WishlistComponent(
                      theme: list,
                    );
                  },
                ),
              )
            : EmptyWidget(icon: KImages.emptyWishlist, text: 'No item found!'),
      ],
    );
  }
}

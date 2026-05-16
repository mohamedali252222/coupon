import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/cart/add_to_cart_model.dart';
import '../../../../data/models/details/product_details_model.dart';
import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../logic/cubit/add_to_cart/add_to_cart_cubit.dart';
import '../../../../logic/cubit/cart/cart_cubit.dart';
import '../../../../logic/cubit/details/details_cubit.dart';
import '../../../../logic/cubit/language_code_state.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/cart_badge.dart';
import '../../../widget/primary_button.dart';
import '../../variant/component/variant_app_bar.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, required this.details});

  final ProductDetailsModel details;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final prod = details.product!;
    debugPrint('cart-product-id ${prod.id}');
    final detailsCubit = context.read<DetailsCubit>();
    final addToCartCubit = context.read<AddToCartCubit>();
    final loginBloc = context.read<LoginBloc>();
    final cartCubit = context.read<CartCubit>();


    return BlocBuilder<CartCubit, LanguageCodeState>(
      builder: (context, state) {
        final isCartProduct = loginBloc.userInformation != null &&
            context.read<CartCubit>().isAlreadyInCart(prod.id);
        return Container(
          height: Utils.vSize(size.height * 0.14),
          width: Utils.vSize(size.width),
          //margin: isCartProduct ? Utils.symmetric() : Utils.all(),
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: whiteColor, boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 36,
              offset: Offset(0, 0),
              spreadRadius: 5,
            )
          ]),
          child: Padding(
            padding: Utils.symmetric(h: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: Utils.all(value: 10.0),
                  margin: Utils.only(
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: Utils.borderRadius(r: 6.0)),
                  child: const CartBadge(),
                ),
                BlocListener<AddToCartCubit, LanguageCodeState>(
                  listener: (context, state) {
                    final addToCart = state.addToCartState;
                    if (addToCart is AddToCartStateLoading) {
                      Utils.loadingDialog(context);
                    } else {
                      Utils.closeDialog(context);
                      if (addToCart is AddToCartStateError) {
                        Utils.errorSnackBar(context, addToCart.message);
                      } else if (addToCart is AddToCartStateAdded) {
                        context.read<CartCubit>().getCartProduct();
                        Utils.showSnackBar(context, addToCart.message);
                      }
                    }
                  },
                  child: isCartProduct
                      ? Expanded(
                          child: PrimaryButton(
                              text: 'Already in Cart',
                              onPressed: () {
                                Utils.showSnackBar(context, 'Already in cart');
                                // Navigator.pushNamed(context, RouteNames.cartScreen);
                              }),
                        )
                      : Expanded(
                          child: PrimaryButton(
                            text: 'Add To Cart',
                            onPressed: () {
                              final data = AddToCartModel(
                                productId: prod.id,
                                variantId: detailsCubit.selectedVariant != null
                                    ? detailsCubit.selectedVariant!.id
                                    : 0,
                                productType: prod.productType,
                                priceType: detailsCubit.priceType
                                    .replaceAll(" ", "_")
                                    .toString(),
                              );

                              if (prod.productType != 'script') {
                                if (detailsCubit.selectedVariant != null) {
                                  addToCartCubit.addToCart(data);
                                } else {
                                  if (loginBloc.userInformation != null &&
                                      prod.author != null) {
                                    final loginEmail =
                                        loginBloc.userInformation!.user!.email;
                                    final authorEmail = prod.author!.email;
                                    if (loginEmail.contains(authorEmail)) {
                                      Utils.showSnackBarWithAction(
                                          context,
                                          "Add new variant",
                                          () => createVariant(
                                              context, prod.id.toString()));
                                    } else {
                                      Utils.showSnackBar(context,
                                          'Request to author for adding variant');
                                    }
                                  }
                                }
                              } else {
                                addToCartCubit.addToCart(data);
                              }
                              // Navigator.pushNamed(context, RouteNames.cartScreen),
                            },
                            // minimumSize: Size(Utils.hSize(size.width * 0.7),
                            //     Utils.vSize(size.height * 0.07)),
                          ),
                        ),

                  // child: BlocBuilder<CartCubit, LanguageCodeState>(
                  //   builder: (context, state) {
                  //     if (isCartProduct) {
                  //       return Expanded(
                  //         child: PrimaryButton(
                  //             text: 'Already in Cart',
                  //             onPressed: () {
                  //               Utils.showSnackBar(context, 'Already in cart');
                  //               // Navigator.pushNamed(context, RouteNames.cartScreen);
                  //             }),
                  //       );
                  //     } else {
                  //       return PrimaryButton(
                  //         text: 'Add To Cart',
                  //         onPressed: () {
                  //           final data = AddToCartModel(
                  //             productId: prod.id,
                  //             variantId: detailsCubit.selectedVariant != null
                  //                 ? detailsCubit.selectedVariant!.id
                  //                 : 0,
                  //             productType: prod.productType,
                  //             priceType: detailsCubit.priceType
                  //                 .replaceAll(" ", "_")
                  //                 .toString(),
                  //           );
                  //
                  //           if (prod.productType != 'script') {
                  //             if (detailsCubit.selectedVariant != null) {
                  //               addToCartCubit.addToCart(data);
                  //             } else {
                  //               if (loginBloc.userInformation != null &&
                  //                   prod.author != null) {
                  //                 final loginEmail =
                  //                     loginBloc.userInformation!.user!.email;
                  //                 final authorEmail = prod.author!.email;
                  //                 if (loginEmail.contains(authorEmail)) {
                  //                   Utils.showSnackBarWithAction(
                  //                       context,
                  //                       "Add new variant",
                  //                       () => createVariant(
                  //                           context, prod.id.toString()));
                  //                 } else {
                  //                   Utils.showSnackBar(context,
                  //                       'Request to author for adding variant');
                  //                 }
                  //               }
                  //             }
                  //           } else {
                  //             addToCartCubit.addToCart(data);
                  //           }
                  //           // Navigator.pushNamed(context, RouteNames.cartScreen),
                  //         },
                  //         minimumSize: Size(Utils.hSize(size.width * 0.7),
                  //             Utils.vSize(size.height * 0.07)),
                  //       );
                  //     }
                  //   },
                  // ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/add_to_cart/add_to_cart_cubit.dart';
import '../../../../logic/cubit/cart/cart_cubit.dart';
import '../../../../logic/cubit/language_code_state.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/action_button.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/feedback_dialog.dart';

class DeleteCartItemDialog extends StatelessWidget {
  const DeleteCartItemDialog({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final addToCartCubit = context.read<AddToCartCubit>();
    return BlocListener<CartCubit, LanguageCodeState>(
      listener: (context, state) {
        final cart = state.cartState;
        if (cart is CartItemRemoving) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (cart is CartRemoveError) {
            //Navigator.pop(context);
            Utils.errorSnackBar(context, cart.message);
          } else if (cart is CartRemoved) {
            //Navigator.pop(context);
            Utils.closeDialog(context);
            Utils.showSnackBar(context, cart.message);
            context.read<CartCubit>().getCartProduct();
            addToCartCubit.countTotalCart();
          }
        }
      },
      child: FeedBackDialog(
        image: KImages.deleteIcon,
        message: 'Are you sure',
        child: Column(
          children: [
            const CustomText(
              text: 'You want to Delete?',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: grayColor,
            ),
            Utils.verticalSpace(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  title: 'Yes',
                  onTap: () => cartCubit.removeCartItem(id),
                  color: blackColor,
                  textColor: whiteColor,
                ),
                Utils.horizontalSpace(18.0),
                ActionButton(
                  title: 'Cancel',
                  onTap: () => Navigator.of(context).pop(),
                  color: primaryColor,
                  textColor: whiteColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

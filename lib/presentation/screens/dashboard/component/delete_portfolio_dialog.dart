import 'package:flutter/material.dart';

import '../../../../logic/cubit/language_code_state.dart';
import '../../../../state_packages_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/action_button.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/feedback_dialog.dart';

class DeletePortfolioDialog extends StatelessWidget {
  const DeletePortfolioDialog({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final dashboardCubit = context.read<DashboardCubit>();
    //final addToCartCubit = context.read<AddToCartCubit>();
    return BlocListener<DashboardCubit, LanguageCodeState>(
      listener: (context, state) {
        final cart = state.dashboardState;
        if (cart is DashboardProductDeleting) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (cart is DashboardDeleteProductError) {
            //Navigator.pop(context);
            Utils.errorSnackBar(context, cart.message);
          } else if (cart is DashboardProductDeleted) {
            Navigator.of(context).pop();
            Utils.showSnackBar(context, cart.message);
            // dashboardCubit.countTotalCart();
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
                  onTap: () => dashboardCubit.deleteProduct(id),
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

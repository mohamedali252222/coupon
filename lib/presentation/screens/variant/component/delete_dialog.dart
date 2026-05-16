import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/variant/variant_cubit.dart';
import '../../../../logic/cubit/variant/variant_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/action_button.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/feedback_dialog.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    final variantCubit = context.read<VariantCubit>();
    return BlocListener<VariantCubit, VariantStateModel>(
      listener: (context, state) {
        final variant = state.variantState;
        if (variant is VariantDeleting) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (variant is VariantDeleteError) {
            Navigator.of(context).pop();
            Utils.errorSnackBar(context, variant.message);
          } else if (variant is VariantDeleted) {
            Utils.showSnackBar(context, variant.delete);
            Navigator.of(context).pop();
          }
        }
      },
      child: FeedBackDialog(
        image: KImages.deleteIcon,
        message: 'Are you sure',
        child: Column(
          children: [
            const CustomText(
              text: 'You want to Delete this item?',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: grayColor,
            ),
            Utils.verticalSpace(16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  title: 'Delete',
                  onTap: () => variantCubit.deleteVariant(id),
                  color: primaryColor,
                  textColor: whiteColor,
                ),
                Utils.horizontalSpace(18.0),
                ActionButton(
                  title: 'Cancel',
                  onTap: () => Navigator.of(context).pop(),
                  color: blackColor,
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

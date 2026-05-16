import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/variant/variant_cubit.dart';
import '../../../../logic/cubit/variant/variant_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/error_text.dart';
import '../../../widget/loading_widget.dart';
import '../../../widget/primary_button.dart';
import 'pick_variant_file.dart';

class VariantAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VariantAppBar({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(top: Utils.vPadding(size: 10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    maxRadius: 18.0,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.arrow_back,
                      size: 22.0,
                      color: whiteColor,
                    ),
                  ),
                ),
                Utils.horizontalSpace(20.0),
                const CustomText(
                  text: 'All Variant',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
              ],
            ),
            GestureDetector(
              onTap: () => createVariant(context, id),
              child: Container(
                //height: Utils.vSize(30.0),
                padding: EdgeInsets.symmetric(
                    horizontal: Utils.hPadding(size: 16.0),
                    vertical: Utils.vPadding(size: 8.0)),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: primaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add),
                    Utils.horizontalSpace(4.0),
                    const CustomText(
                      text: 'Add Variant',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: blueGrayColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      toolbarHeight: Utils.vSize(70.0),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

createVariant(BuildContext context, String id) {
  final variantCubit = context.read<VariantCubit>();
  Utils.showCustomDialog(
    context,
    padding: 30.0,
    child: BlocListener<VariantCubit, VariantStateModel>(
      listener: (context, state) {
        final v = state.variantState;
        if (v is VariantError) {
          Navigator.of(context).pop();
          Utils.errorSnackBar(context, v.message);
        } else if (v is VariantUploaded) {
          //Navigator.of(context).pop();
          Navigator.pop(context);
          Utils.showSnackBar(context, v.upload);
          variantCubit.clear();
          //final id = editProduct.product!.id.toString();
          //context.read<UpdateProductBloc>().add(GetEditProductInfoEvent(id));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Utils.hPadding(size: 16.0), vertical: Utils.vPadding()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const CustomText(
                  text: 'Create New Variant',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      variantCubit.clear();
                    },
                    child: const Icon(Icons.clear, color: redColor))
              ],
            ),
            Utils.verticalSpace(14.0),
            const PickVariantFile(),
            Utils.verticalSpace(14.0),
            BlocBuilder<VariantCubit, VariantStateModel>(
              builder: (context, state) {
                final validate = state.variantState;
                return CustomFormWidget(
                  label: 'Variant name',
                  bottomSpace: 14.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.variantName,
                        decoration: const InputDecoration(
                          hintText: 'Variant name',
                        ),
                        onChanged: (String value) =>
                            variantCubit.changeVariantName(value),
                        keyboardType: TextInputType.text,
                      ),
                      if (validate is VariantFormError) ...[
                        if (validate.errors.variantName.isNotEmpty)
                          ErrorText(text: validate.errors.variantName.first),
                      ]
                    ],
                  ),
                );
              },
            ),
            BlocBuilder<VariantCubit, VariantStateModel>(
              builder: (context, state) {
                final validate = state.variantState;
                return CustomFormWidget(
                  label: 'Variant price',
                  bottomSpace: 24.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.price,
                        decoration: const InputDecoration(
                          hintText: 'Variant price',
                        ),
                        onChanged: (String value) =>
                            variantCubit.changePrice(value),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          //FilteringTextInputFormatter.deny('a'),
                        ],
                      ),
                      if (validate is VariantFormError) ...[
                        if (validate.errors.price.isNotEmpty)
                          ErrorText(text: validate.errors.price.first),
                      ]
                    ],
                  ),
                );
              },
            ),
            BlocBuilder<VariantCubit, VariantStateModel>(
              builder: (context, state) {
                if (state.variantState is VariantUploading) {
                  return const LoadingWidget();
                }
                return PrimaryButton(
                  text: 'Save Variant',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    //final id = editProduct.product!.id.toString();
                    variantCubit.uploadVariant(id);
                  },
                );
              },
            )
          ],
        ),
      ),
    ),
  );
}

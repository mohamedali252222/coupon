import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/models/details/variant/variant_model.dart';
import '../../../data/models/edit/edit_product_model.dart';
import '../../../logic/cubit/update/update_cubit.dart';
import '../../../logic/cubit/variant/variant_cubit.dart';
import '../../../logic/cubit/variant/variant_state_model.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_form.dart';
import '../../widget/custom_text.dart';
import '../../widget/error_text.dart';
import '../../widget/loading_widget.dart';
import '../../widget/primary_button.dart';
import 'component/delete_dialog.dart';
import 'component/empty_variant.dart';
import 'component/pick_variant_file.dart';
import 'component/variant_action_button.dart';
import 'component/variant_app_bar.dart';

class VariantScreen extends StatelessWidget {
  const VariantScreen({super.key, required this.editProduct});

  final EditProductModel editProduct;

  @override
  Widget build(BuildContext context) {
    print(editProduct.variants!.length);
    final id = editProduct.product.id.toString();
    final updateBloc = context.read<UpdateCubit>();
    return Scaffold(
      backgroundColor: homeBgColor.withOpacity(0.99),
      appBar: VariantAppBar(id: id),
      body: BlocListener<VariantCubit, VariantStateModel>(
        listener: (context, state) {
          final delete = state.variantState;
          if (delete is VariantDeleted || delete is VariantUploaded) {
            updateBloc.getEditProduct(id);
          }
        },
        child: editProduct.variants!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: editProduct.variants!.length,
                itemBuilder: (context, index) => VariantCard(
                  variant: editProduct.variants![index],
                  id: editProduct.variants![index].id.toString(),
                ),
              )
            : EmptyVariant(productId: id),
      ),
    );
  }
}

class VariantCard extends StatelessWidget {
  const VariantCard({super.key, required this.variant, required this.id});

  final VariantModel variant;
  final String id;

  @override
  Widget build(BuildContext context) {
    print('variant-name ${variant.variantName}');
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: Utils.hPadding(), vertical: Utils.vPadding(size: 6.0)),
      padding: EdgeInsets.symmetric(
          vertical: Utils.hPadding(), horizontal: Utils.vPadding()),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: variant.variantName,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              CustomText(
                text: Utils.formatPrice(context, variant.price),
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          Container(
            height: 1.0,
            margin: EdgeInsets.symmetric(vertical: Utils.vPadding(size: 10.0)),
            decoration: const BoxDecoration(
              color: borderColor2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // VariantActionButton(
              //   onTap: () {},
              //   bgColor: const Color(0xFF6777EF),
              //   icon: Icons.download,
              // ),
              VariantActionButton(
                onTap: () => updateVariant(context, variant),
                bgColor: const Color(0xFF3BB557),
                icon: FontAwesomeIcons.penToSquare,
              ),
              VariantActionButton(
                onTap: () => showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => DeleteDialog(id: id),
                ),
                bgColor: redColor,
                icon: Icons.delete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

updateVariant(BuildContext context, VariantModel model) {
  final variantCubit = context.read<VariantCubit>();
  // variantCubit.changeFileName(model.fileName);
  variantCubit.changeVariantName(model.variantName);
  variantCubit.changePrice(model.price.toStringAsFixed(0));
  Utils.showCustomDialog(
    context,
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
                  text: 'Update Variant',
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
            BlocBuilder<VariantCubit, VariantStateModel>(
              builder: (context, state) {
                final validate = state.variantState;
                return CustomFormWidget(
                  label: 'Variant name',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: model.variantName,
                        decoration: const InputDecoration(
                          hintText: 'Variant name',
                        ),
                        onChanged: (String value) {
                          variantCubit.changeVariantName(value);
                        },
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: model.price.toStringAsFixed(0),
                        decoration: const InputDecoration(
                          hintText: 'Variant price',
                        ),
                        onChanged: (String value) {
                          variantCubit.changePrice(value);
                        },
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
            Utils.verticalSpace(10.0),
            BlocBuilder<VariantCubit, VariantStateModel>(
              builder: (context, state) {
                if (state.variantState is VariantUploading) {
                  return const LoadingWidget();
                }
                return PrimaryButton(
                  text: 'Save Variant',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    final id = model.id.toString();
                    variantCubit.updateVariant(id);
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

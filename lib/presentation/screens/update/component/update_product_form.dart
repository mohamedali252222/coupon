import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../data/models/edit/edit_product_model.dart';
import '../../../../logic/cubit/update/update_cubit.dart';
import '../../../../logic/cubit/update/update_state_model.dart';
import '../../../../state_packages_name.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/error_text.dart';
import 'image_icon_widget.dart';
import 'pick_project_file.dart';
import 'select_update_category.dart';
import 'update_other_features.dart';

class UpdateProductForm extends StatelessWidget {
  const UpdateProductForm({super.key, required this.product});

  final EditProductModel product;

  @override
  Widget build(BuildContext context) {
    final updateCubit = context.read<UpdateCubit>();
    final size = MediaQuery.sizeOf(context);
    final item = product.product;
    final productLang = product.productLanguage!;
    debugPrint('product-lang $productLang');
    debugPrint('product-lang-name ${productLang.name}');
    debugPrint('product-id ${productLang.id}');
    final isScript = updateCubit.state.productType == 'script';
    return ListView(
      shrinkWrap: true,
      children: [
        UpdateImageIconWidget(editProduct: product),
        Utils.verticalSpace(16.0),
        isScript
            ? PickProjectFile(
                isNew: false,
                downloadTap: () async {
                  print(item.downloadFile);
                  // debugPrint('product-id ${theme.id}');
                  // debugPrint('product-Ttpe ${theme.productType}');
                  final r = await context
                      .read<UpdateCubit>()
                      .downloadExistingScriptFile(item.id.toString());
                  r.fold(
                    (failure) {
                      Utils.errorSnackBar(context, "Something went wrong!");
                    },
                    (success) {
                      if (success) {
                        Utils.showSnackBar(context, "Downloaded");
                      } else {
                        Utils.errorSnackBar(context, "Download Failed");
                      }
                    },
                  );
                },
              )
            : const SizedBox.shrink(),
        Utils.verticalSpace(16.0),
        const SelectUpdatedCategory(),
        Utils.verticalSpace(16.0),
        BlocBuilder<UpdateCubit, UpdateStateModel>(
          builder: (context, state) {
            final validate = state.updateState;
            return CustomFormWidget(
              label: 'Product name',
              bottomSpace: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'product name'),
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {
                      updateCubit.nameChange(value);
                      // final slug = value
                      //     .replaceAll('-', '')
                      //     .replaceAll(' ', '-')
                      //     .toLowerCase();
                      // uploadBloc.add(UploadProductSlugEvent(slug));
                    },
                    initialValue: productLang.name.isNotEmpty
                        ? productLang.name
                        : item.productLangFrontEnd!.name,
                  ),
                  if (validate is UpdateFormValidate) ...[
                    if (validate.errors.name.isNotEmpty)
                      ErrorText(text: validate.errors.name.first),
                  ],
                ],
              ),
            );
          },
        ),
        BlocBuilder<UpdateCubit, UpdateStateModel>(
          builder: (context, state) {
            final validate = state.updateState;
            return CustomFormWidget(
              label: 'Product slug',
              bottomSpace: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'product slug'),
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {
                      final slug = value
                          .replaceAll('-', '')
                          .replaceAll(' ', '-')
                          .toLowerCase();
                      updateCubit.slugChange(slug);
                    },
                    initialValue: item.slug,
                  ),
                  if (validate is UpdateFormValidate) ...[
                    if (validate.errors.slug.isNotEmpty)
                      ErrorText(text: validate.errors.slug.first),
                  ],
                ],
              ),
            );
          },
        ),
        BlocBuilder<UpdateCubit, UpdateStateModel>(
          builder: (context, state) {
            final validate = state.updateState;
            return Row(
              children: [
                Expanded(
                  child: CustomFormWidget(
                    label: 'Regular Price',
                    bottomSpace: 16.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: item.regularPrice.toString(),
                          decoration:
                              const InputDecoration(hintText: 'regular price'),
                          onChanged: (String value) =>
                              updateCubit.regularPriceChange(value),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny('a'),
                          ],
                        ),
                        if (validate is UpdateFormValidate) ...[
                          if (validate.errors.regularPrice.isNotEmpty)
                            ErrorText(text: validate.errors.regularPrice.first),
                        ]
                      ],
                    ),
                  ),
                ),
                Utils.horizontalSpace(16.0),
                isScript
                    ? Expanded(
                        child: CustomFormWidget(
                          label: 'Extended Price',
                          bottomSpace: 16.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                initialValue: item.extendPrice.toString(),
                                decoration: const InputDecoration(
                                    hintText: 'extended price'),
                                onChanged: (String value) =>
                                    updateCubit.extendPriceChange(value),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  FilteringTextInputFormatter.deny('a'),
                                ],
                              ),
                              if (validate is UpdateFormValidate) ...[
                                if (validate.errors.extendPrice.isNotEmpty)
                                  ErrorText(
                                      text: validate.errors.extendPrice.first),
                              ]
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
        BlocBuilder<UpdateCubit, UpdateStateModel>(
          builder: (context, state) {
            final validate = state.updateState;
            return CustomFormWidget(
              label: 'Preview Link',
              bottomSpace: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'preview link'),
                    keyboardType: TextInputType.url,
                    onChanged: (String value) {
                      updateCubit.previewLinkChange(value);
                    },
                    initialValue: item.previewLink,
                  ),
                  if (validate is UpdateFormValidate) ...[
                    if (validate.errors.previewLink.isNotEmpty)
                      ErrorText(text: validate.errors.previewLink.first),
                  ],
                ],
              ),
            );
          },
        ),
        BlocBuilder<UpdateCubit, UpdateStateModel>(
          builder: (context, state) {
            final validate = state.updateState;
            return CustomFormWidget(
              label: 'Description',
              bottomSpace: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'description'),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    onChanged: (String value) {
                      updateCubit.descriptionChange(value);
                    },
                    initialValue: Utils.htmlTextConverter(
                        productLang.description.isNotEmpty
                            ? productLang.description
                            : item.productLangFrontEnd!.description),
                  ),
                  if (validate is UpdateFormValidate) ...[
                    if (validate.errors.description.isNotEmpty)
                      ErrorText(text: validate.errors.description.first),
                  ],
                ],
              ),
            );
          },
        ),
        BlocBuilder<UpdateCubit, UpdateStateModel>(
          builder: (context, state) {
            final validate = state.updateState;
            return CustomFormWidget(
              label: 'Tags',
              bottomSpace: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'tags'),
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {
                      updateCubit.tagsChange(value);
                    },
                    initialValue: productLang.tags.isNotEmpty
                        ? productLang.tags
                        : item.productLangFrontEnd!.tags,
                  ),
                  if (validate is UpdateFormValidate) ...[
                    if (validate.errors.tags.isNotEmpty)
                      ErrorText(text: validate.errors.tags.first),
                  ],
                ],
              ),
            );
          },
        ),
        BlocBuilder<UpdateCubit, UpdateStateModel>(
          builder: (context, state) {
            return CustomFormWidget(
              label: 'Seo Title',
              bottomSpace: 16.0,
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Seo Title'),
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  updateCubit.seoTitleChange(value);
                },
                initialValue: productLang.seoTitle.isNotEmpty
                    ? productLang.seoTitle
                    : item.productLangFrontEnd!.seoTitle,
              ),
            );
          },
        ),
        BlocBuilder<UpdateCubit, UpdateStateModel>(
          builder: (context, state) {
            return CustomFormWidget(
              label: 'Seo Description',
              bottomSpace: 16.0,
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Seo description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (String value) {
                  updateCubit.seoDescriptionChange(value);
                },
                initialValue: productLang.seoDescription.isNotEmpty
                    ? productLang.seoDescription
                    : item.productLangFrontEnd!.seoDescription,
              ),
            );
          },
        ),
        const UpdateOtherFeature(),
        Utils.verticalSpace(size.height * 0.28),
      ],
    );
  }
}

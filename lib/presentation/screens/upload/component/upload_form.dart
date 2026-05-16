import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/widget/custom_form.dart';
import '../../../../logic/bloc/upload_product/upload_product_bloc.dart';
import '../../../../logic/bloc/upload_product/upload_product_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/error_text.dart';
import 'image_icon_widget.dart';
import 'others_features.dart';
import 'pick_project_file.dart';
import 'select_product_category.dart';

class UploadForm extends StatelessWidget {
  const UploadForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final uploadBloc = context.read<UploadProductBloc>();
    final isScript = uploadBloc.state.productType == 'script';
    return ListView(
      shrinkWrap: true,
      primary: true,
      physics: const ClampingScrollPhysics(),
      padding: Utils.only(bottom: size.height * 0.26),
      children: [
        const ImageIconWidget(),
        isScript
            ? PickProjectFile(downloadTap: () {})
            : const SizedBox.shrink(),
        const SelectProductCategory(),
        BlocBuilder<UploadProductBloc, UploadProductStateModel>(
          builder: (context, state) {
            final validate = state.uploadProductState;
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
                      uploadBloc.add(UploadProductNameEvent(value));
                      // final slug = value
                      //     .replaceAll('-', '')
                      //     .replaceAll(' ', '-')
                      //     .toLowerCase();
                      // uploadBloc.add(UploadProductSlugEvent(slug));
                    },
                    initialValue: state.name,
                  ),
                  if (validate is UploadProductFormError) ...[
                    if (validate.errors.name.isNotEmpty)
                      ErrorText(text: validate.errors.name.first),
                  ],
                ],
              ),
            );
          },
        ),
        BlocBuilder<UploadProductBloc, UploadProductStateModel>(
          builder: (context, state) {
            final validate = state.uploadProductState;
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
                      uploadBloc.add(UploadProductSlugEvent(slug));
                    },
                    initialValue: state.slug,
                  ),
                  if (validate is UploadProductFormError) ...[
                    if (validate.errors.slug.isNotEmpty)
                      ErrorText(text: validate.errors.slug.first),
                  ],
                ],
              ),
            );
          },
        ),
        BlocBuilder<UploadProductBloc, UploadProductStateModel>(
          builder: (context, state) {
            final validate = state.uploadProductState;
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
                          initialValue: state.regularPrice,
                          decoration:
                              const InputDecoration(hintText: 'regular price'),
                          onChanged: (String value) => uploadBloc
                              .add(UploadProductRegularPriceEvent(value)),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny('a'),
                          ],
                        ),
                        if (validate is UploadProductFormError) ...[
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
                                initialValue: state.extendPrice,
                                decoration: const InputDecoration(
                                    hintText: 'extended price'),
                                onChanged: (String value) => uploadBloc
                                    .add(UploadProductExtendPriceEvent(value)),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  FilteringTextInputFormatter.deny('a'),
                                ],
                              ),
                              if (validate is UploadProductFormError) ...[
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
        BlocBuilder<UploadProductBloc, UploadProductStateModel>(
          builder: (context, state) {
            final validate = state.uploadProductState;
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
                      uploadBloc.add(UploadProductPreviewLinkEvent(value));
                    },
                    initialValue: state.previewLink,
                  ),
                  if (validate is UploadProductFormError) ...[
                    if (validate.errors.previewLink.isNotEmpty)
                      ErrorText(text: validate.errors.previewLink.first),
                  ],
                ],
              ),
            );
          },
        ),
        BlocBuilder<UploadProductBloc, UploadProductStateModel>(
          builder: (context, state) {
            final validate = state.uploadProductState;
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
                      uploadBloc.add(UploadProductDescriptionEvent(value));
                    },
                    initialValue: state.description,
                  ),
                  if (validate is UploadProductFormError) ...[
                    if (validate.errors.description.isNotEmpty)
                      ErrorText(text: validate.errors.description.first),
                  ],
                ],
              ),
            );
          },
        ),
        BlocBuilder<UploadProductBloc, UploadProductStateModel>(
          builder: (context, state) {
            final validate = state.uploadProductState;
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
                      uploadBloc.add(UploadProductTagsEvent(value));
                    },
                    initialValue: state.tags,
                  ),
                  if (validate is UploadProductFormError) ...[
                    if (validate.errors.tags.isNotEmpty)
                      ErrorText(text: validate.errors.tags.first),
                  ],
                ],
              ),
            );
          },
        ),
        BlocBuilder<UploadProductBloc, UploadProductStateModel>(
          builder: (context, state) {
            return CustomFormWidget(
              label: 'Seo Title',
              bottomSpace: 16.0,
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Seo Title'),
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  uploadBloc.add(UploadProductSeoTitleEvent(value));
                },
                initialValue: state.seoTitle,
              ),
            );
          },
        ),
        BlocBuilder<UploadProductBloc, UploadProductStateModel>(
          builder: (context, state) {
            return CustomFormWidget(
              label: 'Seo Description',
              bottomSpace: 16.0,
              child: TextFormField(
                decoration: const InputDecoration(hintText: 'Seo description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (String value) {
                  uploadBloc.add(UploadProductSeoDescriptionEvent(value));
                },
                initialValue: state.seoDescription,
              ),
            );
          },
        ),
        const OtherFeature(),
      ],
    );
  }
}

class OtherFeatureWidget extends StatelessWidget {
  const OtherFeatureWidget(
      {super.key, required this.child, required this.property});

  final String property;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        child,
        Padding(
          padding: EdgeInsets.only(bottom: Utils.vPadding(size: 5.0)),
          child: CustomText(
            text: property,
            fontSize: 14.0,
            color: blackColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/home/category/home_single_category_model.dart';
import '../../../../logic/bloc/upload_product/upload_product_bloc.dart';
import '../../../../logic/bloc/upload_product/upload_product_state_model.dart';
import '../../../../logic/cubit/home/home_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/error_text.dart';

class SelectProductCategory extends StatelessWidget {
  const SelectProductCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadBloc = context.read<UploadProductBloc>();
    final homeCubit = context.read<HomeCubit>().homeModel!.category!.categories;
    return BlocBuilder<UploadProductBloc, UploadProductStateModel>(
      builder: (context, state) {
        final validate = state.uploadProductState;
        SingleCategoryModel? categoryType;
        if (state.category.isNotEmpty) {
          categoryType =
              homeCubit!.where((e) => e.id.toString() == state.category).first;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormWidget(
              label: 'Select Product Category',
              bottomSpace: 16.0,
              child: DropdownButtonFormField<SingleCategoryModel>(
                hint: const CustomText(
                  text: 'Select Product Type',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: blueGrayColor,
                ),
                isDense: true,
                isExpanded: true,
                value: categoryType,
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: blackColor,
                ),
                items: homeCubit!
                    .map<DropdownMenuItem<SingleCategoryModel>>(
                      (SingleCategoryModel category) => DropdownMenuItem(
                        value: category,
                        child: CustomText(
                          text: category.catLangFrontEndModel!.name.toString(),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: blueGrayColor,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (category) {
                  if (category == null) return;
                  final catId = category.id.toString();
                  //print('category-id $catId');
                  uploadBloc.add(UploadProductCategoryEvent(catId));
                },
              ),
            ),
            if (validate is UploadProductFormError) ...[
              if (validate.errors.category.isNotEmpty)
                ErrorText(text: validate.errors.category.first),
            ]
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/home/category/home_single_category_model.dart';
import '../../../../logic/cubit/home/home_cubit.dart';
import '../../../../logic/cubit/update/update_cubit.dart';
import '../../../../logic/cubit/update/update_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/error_text.dart';

class SelectUpdatedCategory extends StatelessWidget {
  const SelectUpdatedCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadBloc = context.read<UpdateCubit>();
    final homeCubit = context.read<HomeCubit>().homeModel!.category!.categories;
    return BlocBuilder<UpdateCubit, UpdateStateModel>(
      builder: (context, state) {
        SingleCategoryModel categoryType = homeCubit!.first;
        print('st-cat ${uploadBloc.state.category}');
        if (state.category.isNotEmpty) {
          categoryType = homeCubit
              .where((element) => element.id.toString() == state.category)
              .first;
        }
        final validate = state.updateState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<SingleCategoryModel>(
              hint: const CustomText(
                text: 'Select Product Type',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: blueGrayColor,
              ),
              value: categoryType,
              isDense: true,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: blackColor,
              ),
              items: homeCubit
                  .map<DropdownMenuItem<SingleCategoryModel>>(
                    (SingleCategoryModel category) => DropdownMenuItem(
                      value: category,
                      child: CustomText(
                        text: category.catLangFrontEndModel!.name,
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
                uploadBloc.categoryChange(catId);
              },
            ),
            if (validate is UpdateFormValidate) ...[
              if (validate.errors.category.isNotEmpty)
                ErrorText(text: validate.errors.category.first),
            ]
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/dummy_data/sorting_data.dart';
import '../../../../data/models/home/category/home_single_category_model.dart';
import '../../../../logic/cubit/filter/filter_cubit.dart';
import '../../../../logic/cubit/filter/filter_state_model.dart';
import '../../../../logic/cubit/home/home_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/primary_button.dart';
import 'price_section.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<FilterCubit>();
    final category = context.read<HomeCubit>().homeModel!.category!.categories;
    //print('priceee ${filterCubit.product!.maxPrice}');
    return SafeArea(
      child: Drawer(
        backgroundColor: whiteColor,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: Utils.hPadding(size: 12.0)),
          children: [
            Utils.verticalSpace(40.0),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
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
            ),
            Utils.verticalSpace(20.0),
            BlocBuilder<FilterCubit, FilterStateModel>(
              builder: (context, state) {
                return CustomFormWidget(
                  label: 'Keyword',
                  child: TextFormField(
                    initialValue: state.keyword,
                    decoration: const InputDecoration(hintText: 'keyword'),
                    keyboardType: TextInputType.text,
                    onChanged: (String value) =>
                        filterCubit.changeKeyword(value),
                  ),
                );
              },
            ),
            BlocBuilder<FilterCubit, FilterStateModel>(
              builder: (context, state) {
                //SortModel? sortType;
                // if (state.sorting.isNotEmpty) {
                //   sortType = sortData
                //       .where((element) => element.id.toString() == state.sorting)
                //       .first;
                // }
                return CustomFormWidget(
                  label: 'Sorting Type',
                  child: DropdownButtonFormField<SortModel>(
                    hint: const CustomText(
                      text: 'Select Sorting Type',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: blueGrayColor,
                    ),
                    isDense: true,
                    isExpanded: true,
                    //value: sortType,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: blackColor,
                    ),
                    items: sortData
                        .map<DropdownMenuItem<SortModel>>(
                          (SortModel sort) => DropdownMenuItem(
                            value: sort,
                            child: CustomText(
                              text: sort.name,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: blueGrayColor,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (payment) {
                      if (payment == null) return;
                      final sorting = payment.name
                          .replaceAll(' ', '')
                          .replaceAll('Product', '')
                          .replaceAll('Sorting', '')
                          .toLowerCase();
                      print('sort $sorting');
                      filterCubit.changeSorting(sorting);
                    },
                  ),
                );
              },
            ),
            BlocBuilder<FilterCubit, FilterStateModel>(
              builder: (context, state) {
                return CustomFormWidget(
                    label: 'Categories',
                    child: DropdownButtonFormField<SingleCategoryModel>(
                      hint: const CustomText(
                        text: 'Select Categories',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: blueGrayColor,
                      ),
                      isDense: true,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: blackColor,
                      ),
                      items: category!
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
                      onChanged: (payment) {
                        if (payment == null) return;
                        final category = payment.slug;
                        // final category = payment.name.replaceAll(' ', '-').toLowerCase();
                        print('sort $category');
                        filterCubit.changeCategory(category);
                      },
                    ));
              },
            ),
            CustomFormWidget(
                label: 'Price',
                child: PriceSection(
                    totalPrice: filterCubit.product!.productMaxPrice)),
            Utils.verticalSpace(20.0),
            PrimaryButton(
                text: 'Filter',
                onPressed: () {
                  debugPrint('currency ${filterCubit.state.currencyRate}');
                  Utils.closeKeyBoard(context);
                  Scaffold.of(context).closeEndDrawer();
                  filterCubit.getFilteredProduct();
                  //filterCubit.clear();
                }),
          ],
        ),
      ),
    );
  }
}

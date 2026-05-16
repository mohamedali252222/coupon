import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/dummy_data/dummy_data.dart';
import '../../../data/dummy_data/sorting_data.dart';
import '../../../logic/bloc/upload_product/upload_product_bloc.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/custom_text.dart';
import '../../widget/primary_button.dart';

class UploadProductTypeScreen extends StatelessWidget {
  const UploadProductTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final homeCubit = context.read<HomeCubit>();
    // debugPrint(
    //     'homeCubit ${homeCubit.homeModel!.category!.categories!.length}');
    // final categories = homeCubit.homeModel!.category!.categories!;
    final uploadBloc = context.read<UploadProductBloc>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
              title: 'Product Type', isGradientBg: true, iconColor: whiteColor),
          SliverPadding(
            padding: Utils.symmetric(),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              const CustomText(
                  text: 'Product Upload',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: blackColor),
              Utils.verticalSpace(5.0),
              const CustomText(
                text: 'Select a category for your Product',
                fontSize: 16.0,
                color: primaryColor,
              ),
              Utils.verticalSpace(15.0),
              DropdownButtonFormField<ProductType>(
                hint: const CustomText(
                  text: 'Select Product Type',
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
                items: uploadProductTypes
                    .map<DropdownMenuItem<ProductType>>(
                      (ProductType payment) => DropdownMenuItem(
                        value: payment,
                        child: CustomText(
                          text: payment.type,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: blueGrayColor,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (payment) {
                  if (payment == null) return;
                  final productType = payment.type.toLowerCase();
                  debugPrint('productType $productType');
                  uploadBloc.add(UploadProductTypeEvent(productType));
                },
              ),
              // CustomImage(path: RemoteUrls.imageUrl(productType.image)),
              Utils.verticalSpace(30.0),
              const CustomText(
                  text: 'Need help selecting a category?',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: blackColor),
              Utils.verticalSpace(10.0),
              CustomText(
                text: description,
                fontSize: 16.0,
                maxLine: 3,
                color: grayColor,
              ),
              Utils.verticalSpace(30.0),
              PrimaryButton(
                text: 'Next',
                onPressed: () {
                  if (uploadBloc.state.productType.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      RouteNames.uploadScreen,
                    );
                  } else {
                    Utils.showSnackBar(context, 'Please select product type');
                  }
                },
              ),
            ])),
          )
        ],
      ),
    );
  }
}

import 'package:alas_mart/logic/cubit/currency/currency_cubit.dart';
import 'package:alas_mart/logic/cubit/currency/currency_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/home/product/single_product_model.dart';
import '../../../../logic/cubit/home/home_cubit.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import '../../wishlist/favourite_button.dart';
import 'heading.dart';

class TrendingHorizontalProduct extends StatelessWidget {
  const TrendingHorizontalProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final trending = homeCubit.homeModel!.trendingSection!;
    debugPrint('trending-length ${trending.trendingProducts!.length}');
    return Column(
      children: [
        Heading(
            title1: 'Trending Theme',
            onTap: () =>
                Navigator.pushNamed(context, RouteNames.trendingScreen)),
        itemSpace,
        // SizedBox(
        //   height: 440.0,
        //   child: ListView.builder(
        //       shrinkWrap: true,
        //       scrollDirection: Axis.vertical,
        //       //padding: Utils.only(top: 8.0),
        //       physics: const NeverScrollableScrollPhysics(),
        //       itemCount: trending.trendingProducts!.length >= 3
        //           ? 3
        //           : trending.trendingProducts!.length,
        //       itemBuilder: (context, index) {
        //         final item = trending.trendingProducts![index];
        //         return GestureDetector(
        //             onTap: () => Navigator.pushNamed(
        //                 context, RouteNames.detailScreen,
        //                 arguments: item.slug),
        //             child: SingleTrendingCard(theme: item));
        //       }),
        // ),
        ...List.generate(
            trending.trendingProducts!.length >= 3
                ? 3
                : trending.trendingProducts!.length, (index) {
          final item = trending.trendingProducts![index];
          return GestureDetector(
              onTap: () => Navigator.pushNamed(context, RouteNames.detailScreen,
                  arguments: item.slug),
              child: SingleTrendingCard(theme: item));
        }),
      ],
    );
  }
}

class SingleTrendingCard extends StatelessWidget {
  const SingleTrendingCard({super.key, required this.theme});

  final SingleProductModel theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Utils.symmetric(v: 12.0),
      margin: Utils.symmetric(v: 14.0, h: 12.0).copyWith(top: 0.0),
      height: Utils.vSize(140.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: Utils.borderRadius(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                    borderRadius: Utils.borderRadius(r: 6.0),
                    child: Stack(
                      children: [
                        CustomImage(
                            path: RemoteUrls.imageUrl(theme.thumbnailImage)),
                        Positioned(
                          child: FavouriteButton(productId: theme.id),
                        ),
                      ],
                    )),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: Utils.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: CustomText(
                              text: theme.category!.catLangFrontEndModel!.name,
                              fontSize: 16.0,
                              color: primaryColor),
                        ),
                        Flexible(
                          child: CustomText(
                            text: theme.name.isNotEmpty
                                ? theme.name
                                : theme.productLangFrontEnd!.name,
                            color: blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            maxLine: 2,
                            height: 1.4,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Utils.verticalSpace(6.0),
                        BlocBuilder<CurrencyCubit, CurrencyStateModel>(
                            builder: (context, state) {
                          return CustomText(
                            text:
                                Utils.formatPrice(context, theme.regularPrice),
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: primaryColor,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

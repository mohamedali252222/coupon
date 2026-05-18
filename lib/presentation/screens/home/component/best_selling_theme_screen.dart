import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/details/product_item_model.dart';
import '../../../../logic/cubit/home/home_cubit.dart';
import '../../../../logic/cubit/language_code_state.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_sliver_app_bar.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/loading_widget.dart';
import '../../../widget/product_rating.dart';
import '../../wishlist/favourite_button.dart';

class BestSellingThemeScreen extends StatelessWidget {
  const BestSellingThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    final homeCubit = context.read<HomeCubit>();
    homeCubit.getBestSellingProduct();
    // if (homeCubit.bestProduct.isEmpty) {
    //   debugPrint('bestProduct got NULL');
    //   //homeCubit.getBestSellingProduct();
    // }
    return Scaffold(
      backgroundColor: homeBgColor.withOpacity(0.99),
      body: BlocConsumer<HomeCubit, LanguageCodeState>(
        listener: (context, state) {
          final home = state.homeState;
          if (home is HomeStateError) {
            if (home.statusCode == 503 || homeCubit.homeModel == null) {
              homeCubit.getBestSellingProduct();
            }
          }
        },
        builder: (context, state) {
          final home = state.homeState;
          if (home is HomeStateLoading) {
            return const LoadingWidget();
          } else if (home is HomeStateError) {
            if (home.statusCode == 503) {
              if (homeCubit.homeModel != null) {
                return LoadedBestSellingProduct(
                    bestProduct: homeCubit.bestProduct);
              }
            } else {
              return const FetchErrorText(text: 'Network problem');
            }
            return FetchErrorText(text: home.message);
          } else if (home is HomeStateBestSellingLoaded) {
            return LoadedBestSellingProduct(bestProduct: home.bestProduct);
          }
          if (homeCubit.homeModel != null) {
            return LoadedBestSellingProduct(bestProduct: homeCubit.bestProduct);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

class LoadedBestSellingProduct extends StatelessWidget {
  const LoadedBestSellingProduct({super.key, required this.bestProduct});

  final List<ProductItemModel> bestProduct;

  // final List<BestProductModel> bestProduct;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    debugPrint('bestProduct-length ${bestProduct.length}');
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'أكثر العروض مبيعًا',
          isGradientBg: true,
          iconColor: whiteColor,
        ),
        SliverPadding(
          padding: Utils.symmetric(h: 8.0,v: 8.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  SliverGridViewComponent(theme: bestProduct[index]),
              childCount: bestProduct.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              // childAspectRatio: 0.80,
              mainAxisExtent: Utils.vSize(size.height * 0.31),
              mainAxisSpacing: 10.0,
            ),
          ),
        ),
      ],
    );
  }
}

class SliverGridViewComponent extends StatelessWidget {
  const SliverGridViewComponent({super.key, required this.theme});

  final ProductItemModel theme;

  // final BestProductModel theme;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteNames.detailScreen,
          arguments: theme.slug),
      child: Container(
        // height: Utils.vSize(size.height * 0.4),
        //width: Utils.hSize(size.width * 0.6),
        padding: Utils.symmetric(v: 8.0, h: 0.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: Utils.borderRadius(r: 8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Utils.vSize(size.height * 0.16),
              //width: Utils.hSize(size.width * 0.6),
              padding: Utils.symmetric(h: 6.0, v: 10.0).copyWith(top: 0.0),

              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomImage(
                      path: RemoteUrls.imageUrl(theme.thumbnailImage),
                      fit: BoxFit.cover,
                      height: Utils.vSize(size.height * 0.16),
                      width: Utils.hSize(size.width * 0.6),
                    ),
                    Positioned(
                      top: Utils.vSize(10.0),
                      right: Utils.hSize(10.0),
                      child: Container(
                        height: Utils.vSize(42.0),
                        //width: Utils.hSize(45.0),
                        padding: Utils.symmetric(h: 8.0),
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: Utils.borderRadius(r: 4.0),
                        ),
                        child: Transform.translate(
                          offset: const Offset(0.0, 6.0),
                          child: CustomText(
                            text:
                                Utils.formatPrice(context, theme.regularPrice),
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: Utils.vSize(10.0),
                      left: Utils.hSize(10.0),
                      child: FavouriteButton(productId: theme.id),
                      // child: const Icon(
                      //   Icons.favorite_border,
                      //   size: 28.0,
                      //   color: grayColor,
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: Utils.symmetric(h: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: theme.category!.catLangFrontEndModel!.name,
                          fontSize: 14.0,
                          color: primaryColor),
                      ProductRating(rating: theme.totalRating, iconSize: 14.0),
                    ],
                  ),
                  Utils.verticalSpace(4.0),
                  Flexible(
                    fit: FlexFit.loose,
                    child: CustomText(
                      text: theme.name.isNotEmpty
                          ? theme.name
                          : theme.productLangFrontEnd!.name,
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      maxLine: 2,
                      height: 1.6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    height: 0.5,
                    margin: Utils.symmetric(h: 0.0, v: 6.0),
                    color: const Color(0xFFEAEAEA),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sellCount(Icons.download,
                          ' ${theme.totalSold} عملية شراء'),
                      //_sellCount(FontAwesomeIcons.heart, '120'),
                      // Utils.hSpace(40.0),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sellCount(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 16.0, color: grayColor),
        Utils.horizontalSpace(4.0),
        CustomText(
          text: count,
          fontSize: 16.0,
          color: grayColor,
        ),
      ],
    );
  }
}

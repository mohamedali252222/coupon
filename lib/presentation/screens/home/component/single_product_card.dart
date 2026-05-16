import 'package:alas_mart/logic/cubit/currency/currency_cubit.dart';
import 'package:alas_mart/logic/cubit/currency/currency_state_model.dart';
import 'package:alas_mart/state_packages_name.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/details/product_item_model.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/product_rating.dart';
import '../../wishlist/favourite_button.dart';
import '/presentation/utils/utils.dart';
import '/presentation/widget/custom_image.dart';

class SingleProductCard extends StatelessWidget {
  const SingleProductCard({Key? key, required this.theme}) : super(key: key);

  //final SingleProductModel theme;
  final ProductItemModel theme;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final review = theme.totalReview.toInt();
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteNames.detailScreen,
          arguments: theme.slug),
      child: Container(
        // height: Utils.vSize(size.height * 0.4),
        width: Utils.hSize(size.width * 0.50),
        margin: Utils.symmetric(h: 8.0),
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
              height: Utils.vSize(size.height * 0.18),
              width: Utils.hSize(size.width * 0.6),
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
                      height: Utils.vSize(size.height * 0.18),
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
                          child: BlocBuilder<CurrencyCubit, CurrencyStateModel>(
                              builder: (context, state) {
                            return CustomText(
                              text: Utils.formatPrice(
                                  context, theme.regularPrice),
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: whiteColor,
                            );
                          }),
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
                          fontSize: 16.0,
                          color: primaryColor),
                      ProductRating(rating: theme.totalRating),
                      // Row(
                      //   children: List.generate(
                      //     5,
                      //     (index) => const Icon(
                      //       Icons.star,
                      //       size: 18.0,
                      //       color: secondaryColor,
                      //     ),
                      //   ),
                      // ),
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
                      height: 1.4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    height: 0.7,
                    margin: Utils.symmetric(h: 0.0, v: 8.0),
                    color: const Color(0xFFEAEAEA),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sellCount(FontAwesomeIcons.download,
                          ' ${theme.totalSold} Sell'),
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

  //
  // Widget buildPositioned() {
  //   return Positioned(
  //     top: Utils.vSize(10.0),
  //     left: Utils.hSize(10.0),
  //     //child: BookmarkButton(productId: theme.id),
  //     child: Container(
  //       height: Utils.vSize(40.0),
  //       width: Utils.hSize(40.0),
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         border: Border.all(color: const Color(0xFFCBCBCB)),
  //       ),
  //       child: Icon(
  //         Icons.favorite_border,
  //         size: 30.0,
  //         color: grayColor,
  //       ),
  //     ),
  //   );
  // }

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

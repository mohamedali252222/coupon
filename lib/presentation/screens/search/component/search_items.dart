import 'package:flutter/material.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/details/product_item_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import '../../wishlist/favourite_button.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({super.key, required this.theme});

  final ProductItemModel theme;

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
                        CustomText(
                            text: theme.category!.catLangFrontEndModel!.name,
                            fontSize: 16.0,
                            color: primaryColor),
                        CustomText(
                          text: theme.name.isNotEmpty
                              ? theme.name
                              : theme.productLangFrontEnd!.name,
                          color: blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          maxLine: 2,
                          height: 1.6,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Utils.verticalSpace(4.0),
                        CustomText(
                          text: Utils.formatPrice(context, theme.regularPrice),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: primaryColor,
                        ),
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

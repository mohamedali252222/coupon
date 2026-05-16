import 'package:flutter/material.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/cart/cart_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import 'delete_cart_item.dart';

class CartComponent extends StatelessWidget {
  const CartComponent({super.key, required this.theme});

  final CartItemModel theme;

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                    borderRadius: Utils.borderRadius(r: 6.0),
                    child: CustomImage(
                        path: RemoteUrls.imageUrl(
                            theme.product!.thumbnailImage))),
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
                          text: theme.product!.name.isNotEmpty
                              ? theme.product!.name
                              : theme.product!.productLangFrontEnd!.name,
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
                          text: Utils.formatPrice(
                              context, theme.product!.regularPrice),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                _deleteIcon(context, theme.id.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _deleteIcon(BuildContext context, String id) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => DeleteCartItemDialog(id: id),
        );
      },
      child: CircleAvatar(
        maxRadius: 18.0,
        backgroundColor: redColor.withOpacity(0.2),
        child: const Icon(
          Icons.delete,
          color: redColor,
          size: 20.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/details/product_item_model.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import 'delete_portfolio_dialog.dart';

class PortfolioComponent extends StatelessWidget {
  const PortfolioComponent({super.key, required this.theme});

  final ProductItemModel theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Utils.symmetric(v: 12.0, h: 12.0),
      margin: Utils.symmetric(v: 14.0, h: 12.0).copyWith(top: 0.0),
      height: Utils.vSize(140.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: Utils.borderRadius(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 140.0,
                  width: 160.0,
                  child: ClipRRect(
                      borderRadius: Utils.borderRadius(r: 6.0),
                      child: Stack(
                        children: [
                          CustomImage(
                            path: RemoteUrls.imageUrl(theme.thumbnailImage),
                            fit: BoxFit.cover,
                            height: 140.0,
                            width: 160.0,
                          ),
                          Positioned(
                            left: 5.0,
                            top: 5.0,
                            child: GestureDetector(
                              onTap: () {
                                print('preview-link ${theme.previewLink}');
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.updateProduct,
                                  arguments: theme.id.toString(),
                                );
                              },
                              child: const CircleAvatar(
                                maxRadius: 18.0,
                                backgroundColor: redColor,
                                child: Icon(
                                  Icons.edit,
                                  color: whiteColor,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: Utils.only(left: 10.0),
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
                          fit: FlexFit.loose,
                          child: CustomText(
                            text: theme.productLangFrontEnd!.name,
                            color: blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            maxLine: 2,
                            height: 1.6,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
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
          _deleteIcon(context, theme.id.toString()),
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
          builder: (context) => DeletePortfolioDialog(id: id),
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

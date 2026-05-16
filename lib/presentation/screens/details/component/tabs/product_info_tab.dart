import 'package:flutter/material.dart';

import '../../../../../data/models/details/product_item_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text.dart';

class ProductInfoTab extends StatelessWidget {
  const ProductInfoTab({super.key, required this.product});

  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _productInfo('Released', Utils.formatDate(product.createdAt)),
        _productInfo('Updated', Utils.formatDate(product.updatedAt)),
        _productInfo('File Type', product.productType),
        _productInfo('High Resolution', description(product.highResolution)),
        _productInfo('Cross browser', description(product.crossBrowser)),
        _productInfo('Documentation', description(product.documentation)),
        _productInfo('Responsive', description(product.layout)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              text: 'Tags',
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: blueGrayColor,
            ),
            Flexible(
              child: CustomText(
                text: product.productLangFrontEnd!.tags,
                fontSize: 15.0,
                color: primaryColor,
                height: 1.5,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productInfo(String text, String value) {
    return Padding(
      padding: Utils.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: blueGrayColor,
          ),
          CustomText(
            text: value,
            fontSize: 18.0,
            color: grayColor,
          ),
        ],
      ),
    );
  }

  String description(int code) {
    if (code == 1) {
      return 'Yes';
    } else {
      return 'No';
    }
  }
}

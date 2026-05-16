import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../../../../data/models/details/product_item_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text.dart';

class DescriptionTab extends StatelessWidget {
  const DescriptionTab({super.key, required this.product});

  final ProductItemModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Item Description:',
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
        Utils.verticalSpace(10.0),
        // CustomText(
        //   text: product.productLangFrontEnd!.description,
        //   fontSize: 15.5,
        //   color: grayColor,
        //   maxLine: 10,
        // ),
        ReadMoreText(
            Utils.htmlTextConverter(product.productLangFrontEnd!.description),
            style: GoogleFonts.rubik(color: grayColor, fontSize: 15.0)),
        // Html(
        //   data:
        //       Utils.htmlTextConverter(product.productLangFrontEnd!.description),
        //   style: {
        //     'p': Style(
        //       fontSize: FontSize.medium,
        //       color: redColor,
        //     ),
        //   },
        // ),
        Utils.verticalSpace(20.0),
        // const CustomText(
        //   text: 'Features',
        //   fontSize: 20.0,
        //   fontWeight: FontWeight.w700,
        // ),
        // Utils.verticalSpace(10.0),
        // CustomText(
        //   text: description,
        //   fontSize: 15.5,
        //   color: grayColor,
        //   maxLine: 10,
        // ),
        // Utils.verticalSpace(10.0),
        // ...List.generate(
        //   featureText.length,
        //   (index) => _keyFeatures(featureText[index]),
        // ),
        // Utils.verticalSpace(20.0),
        // const CustomText(
        //   text: 'File Included',
        //   fontSize: 20.0,
        //   fontWeight: FontWeight.w700,
        // ),
        // Utils.verticalSpace(10.0),
        // CustomText(
        //   text: description,
        //   fontSize: 15.5,
        //   color: grayColor,
        //   maxLine: 10,
        // ),
        // Utils.verticalSpace(10.0),
        // ...List.generate(
        //   fileText.length,
        //   (index) => _keyFeatures(fileText[index]),
        // ),
      ],
    );
  }

  Widget _keyFeatures(String text) {
    return Padding(
      padding: Utils.only(bottom: 6.0),
      child: Row(
        children: [
          Padding(
            padding: Utils.only(top: 2.0, right: 6.0),
            child:
                const Icon(Icons.check_circle, color: primaryColor, size: 24.0),
          ),
          CustomText(text: text)
        ],
      ),
    );
  }
}

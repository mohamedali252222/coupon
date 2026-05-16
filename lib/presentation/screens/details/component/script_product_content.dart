import 'package:flutter/material.dart';

import '../../../../data/models/details/product_details_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';
import 'price_section.dart';

class ScriptProductContent extends StatefulWidget {
  const ScriptProductContent({super.key, required this.details});

  final ProductDetailsModel details;

  @override
  State<ScriptProductContent> createState() => _ScriptProductContentState();
}

class _ScriptProductContentState extends State<ScriptProductContent> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.details;
    final extendedText = [
      'Regular Price',
      'Extended Price',
    ];
    final List<String> services = [
      product.scriptContent!.regularContent,
      product.scriptContent!.extendContent,
    ];
    return Container(
      padding: Utils.symmetric(v: 12.0, h: 0.0),
      margin: Utils.symmetric(v: 12.0, h: 0.0),
      decoration: BoxDecoration(
          color: grayColor2, borderRadius: Utils.borderRadius(r: 0.0)),
      child: Column(
        children: [
          PriceSection(
            price: _currentIndex == 0
                ? product.product!.regularPrice
                : product.product!.extendPrice,
            totalSale: product.totalSale,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              services.length,
              (index) {
                final active = _currentIndex == index;
                return Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    childrenPadding: Utils.symmetric(),
                    leading: GestureDetector(
                      onTap: () => setState(() {
                        _currentIndex = index;
                      }),
                      child: AnimatedContainer(
                        duration: kDuration,
                        height: Utils.vSize(26.0),
                        width: Utils.hSize(26.0),
                        //margin: const EdgeInsets.only(right: 0.0),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          shape: BoxShape.circle,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            //color: primaryColor,
                            color: active ? primaryColor : transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    title: CustomText(
                      text: extendedText[index],
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    // subtitle: Container(
                    //   height: 2.0,
                    //   color: grayColor.withOpacity(0.2),
                    // ),

                    children: [
                      Container(
                        height: 1.0,
                        margin: Utils.symmetric(v: 6.0).copyWith(top: 0.0),
                        color: grayColor.withOpacity(0.2),
                      ),
                      CustomText(
                        text: Utils.htmlTextConverter(services[index]),
                        height: 1.8,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

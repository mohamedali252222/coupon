import 'package:flutter/material.dart';

import '../../../../data/dummy_data/dummy_data.dart';
import '../../../../data/models/details/product_item_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../home/component/heading.dart';
import '../../home/component/single_product_card.dart';

class RelativeProductCard extends StatelessWidget {
  const RelativeProductCard({super.key, required this.relatedProducts});

  final List<ProductItemModel> relatedProducts;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: homeBgColor.withOpacity(0.3),
        padding: Utils.symmetric(v: 0.0, h: 0.0).copyWith(bottom: 20.0),
        child: Column(
          children: [
            const Heading(
              title1: 'Relative Product',
              seeAllVisible: false,
            ),
            itemSpace,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Row(
                children: List.generate(
                  relatedProducts.length,
                  (index) => Padding(
                    padding: Utils.only(
                        left: index == 0 ? 10.0 : 0.0,
                        right: index == themes.length - 1 ? 10.0 : 0.0),
                    child: SingleProductCard(
                      theme: relatedProducts[index],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

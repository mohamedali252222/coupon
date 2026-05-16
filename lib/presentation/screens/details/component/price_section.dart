import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({super.key, required this.price, required this.totalSale});

  final double price;
  final int totalSale;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.vSize(60.0),
      width: double.infinity,
      padding: Utils.symmetric(h: 14.0),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(Utils.radius(6.0)),
            topLeft: Radius.circular(Utils.radius(6.0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: Utils.formatPrice(context, price),
            color: whiteColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
          Row(
            children: [
              _sellCount(FontAwesomeIcons.download, ' $totalSale Sell'),
              // Utils.hSpace(40.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sellCount(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 16.0, color: whiteColor),
        Utils.horizontalSpace(4.0),
        CustomText(
          text: count,
          fontSize: 16.0,
          color: whiteColor,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';

class SingleCategoryCard extends StatelessWidget {
  const SingleCategoryCard({
    Key? key,
    this.onTap,
    required this.name,
    required this.icon,
    this.height = 85.0,
    this.width = 80.0,
  }) : super(key: key);

  final Function()? onTap;
  final String icon;
  final String name;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Utils.vSize(height),
          width: Utils.hSize(width),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: Utils.borderRadius(r: 6.0),
          ),
          alignment: Alignment.center,
          padding: Utils.all(value: 10.0),
          margin: Utils.symmetric(h: 6.0, v: 0.0).copyWith(top: 0.0),
          child: CustomImage(
            path: icon,
            height: 50.0,
            fit: BoxFit.cover,
          ),
        ),
        Utils.verticalSpace(2.0),
        CustomText(
          text: name,
          color: blueGrayColor,
          fontWeight: FontWeight.w500, //162B49
          fontSize: 14.0,
        ),
      ],
    );
  }
}

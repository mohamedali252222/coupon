import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text.dart';

class CustomFormWidget extends StatelessWidget {
  final String label;
  final Widget child;
  final double bottomSpace;
  final Color labelColor;

  const CustomFormWidget({
    super.key,
    required this.label,
    required this.child,
    this.bottomSpace = 0.0,
    this.labelColor = blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14.0,
          color: labelColor,
        ),
        Utils.verticalSpace(10.0),
        child,
        Utils.verticalSpace(bottomSpace),
      ],
    );
  }
}

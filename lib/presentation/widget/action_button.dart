import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'custom_text.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.color,
    required this.textColor,
  });

  final String title;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Utils.vSize(50.0),
        width: Utils.hSize(120.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(4.0)),
        child: CustomText(
          text: title,
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          color: textColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';

class VariantActionButton extends StatelessWidget {
  const VariantActionButton({
    super.key,
    required this.onTap,
    required this.bgColor,
    required this.icon,
  });

  final IconData icon;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Utils.vSize(40.0),
        width: Utils.hSize(40.0),
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            right: Utils.hPadding(size: 10.0), top: Utils.vSize(4.0)),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: Utils.hPadding(size: 2.0)),
          child: Icon(icon, color: whiteColor, size: 20.0),
        ),
      ),
    );
  }
}

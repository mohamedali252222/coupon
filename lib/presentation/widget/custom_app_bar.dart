import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.isShowBackButton = true,
    this.isGradientBg = false,
    this.textSize = 22.0,
    this.fontWeight = FontWeight.w700,
    this.textColor = blackColor,
    this.iconColor = blackColor,
  });

  final String title;
  final bool isShowBackButton;
  final bool isGradientBg;
  final double textSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isShowBackButton ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        isShowBackButton
            ? BackButtonWidget(isGradientBg: isGradientBg, iconColor: iconColor)
            : const SizedBox(),
        Padding(
          padding: Utils.only(bottom: 5.0),
          child: CustomText(
            text: title,
            fontSize: textSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
    this.isGradientBg = false,
    this.iconColor = blackColor,
  });

  final bool isGradientBg;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.maybePop(context),
      child: Container(
        height: Utils.vSize(48.0),
        width: Utils.hSize(46.0),
        alignment: Alignment.center,
        margin: Utils.only(right: 25.0),
        decoration: isGradientBg
            ? BoxDecoration(
                borderRadius: Utils.borderRadius(r: 8.0),
                gradient: linearGradient,
              )
            : BoxDecoration(
                color: whiteColor,
                borderRadius: Utils.borderRadius(r: 8.0),
                border: Border.all(color: grayColor.withOpacity(0.5)),
              ),
        child: Padding(
          padding: Utils.only(left: 8.0),
          child: Icon(Icons.arrow_back_ios, color: iconColor),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    this.maximumSize = const Size(double.infinity, 52),
    required this.text,
    this.fontSize = 14.0,
    required this.onPressed,
    this.textColor = whiteColor,
    this.bgColor = primaryColor,
    this.minimumSize = const Size(double.infinity, 52),
    this.borderRadiusSize = 10.0,
  }) : super(key: key);

  final VoidCallback? onPressed;

  final String text;
  final Size maximumSize;
  final Size minimumSize;
  final double fontSize;
  final double borderRadiusSize;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(borderRadiusSize);
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          // begin: Alignment(-0.80, -0.60),
          // end: Alignment(0.8, 0.60),
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: Utils.borderRadius(r: borderRadiusSize),
      ),
      // decoration: ShapeDecoration(
      //     gradient: const LinearGradient(
      //       begin: Alignment(0.80, -0.60),
      //       end: Alignment(-0.8, 0.6),
      //       colors: [Color(0xFF1000FF), Color(0xFF0086FF)],
      //     ),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     )),

      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(transparent),
          splashFactory: NoSplash.splashFactory,
          shadowColor: MaterialStateProperty.all(transparent),
          overlayColor: MaterialStateProperty.all(transparent),
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: borderRadius)),
          minimumSize: MaterialStateProperty.all(minimumSize),
          maximumSize: MaterialStateProperty.all(maximumSize),
        ),
        child: CustomText(
          text: text,
          color: textColor,
          fontSize: fontSize.sp,
          height: 1.5.h,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

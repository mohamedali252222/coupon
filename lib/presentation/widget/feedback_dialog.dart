import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_image.dart';
import 'custom_text.dart';

class FeedBackDialog extends StatelessWidget {
  const FeedBackDialog(
      {super.key,
      required this.image,
      required this.message,
      required this.child,
      this.bgColor = primaryColor,
      this.height = 224.0});

  final String image;
  final String message;
  final Widget child;
  final double height;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 4.0,
      insetPadding: Utils.symmetric(h: 14.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      child: SizedBox(
        width: Utils.hSize(330.0),
        height: Utils.vSize(height),
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            Positioned(
              top: Utils.vPadding(size: -45.0),
              left: Utils.vPadding(size: 0.0),
              right: Utils.vPadding(size: 0.0),
              child: Container(
                width: Utils.hSize(100.0),
                height: Utils.vSize(100.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 6.0, color: whiteColor),
                  shape: BoxShape.circle,
                  color: bgColor,
                ),
                child: CustomImage(
                  path: image,
                  width: Utils.hSize(41.0),
                  height: Utils.vSize(46.0),
                ),
              ),
            ),
            Positioned.fill(
              top: Utils.vPadding(size: 50.0),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Utils.hPadding(size: 14.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Utils.verticalSpace(15.0),
                    CustomText(
                      text: message,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                      color: blueGrayColor,
                    ),
                    Utils.verticalSpace(6.0),
                    child,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

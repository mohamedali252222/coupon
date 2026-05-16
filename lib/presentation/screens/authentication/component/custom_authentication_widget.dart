import 'package:flutter/material.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_image.dart';

class CustomAuthenticationWidget extends StatelessWidget {
  const CustomAuthenticationWidget({
    super.key,
    required this.child,
    this.height = 0.0,
    this.isShowBackButton = true,
    this.topChild = const SizedBox(),
  });

  final Widget child;
  final double height;
  final bool isShowBackButton;
  final Widget topChild;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fromTop = Utils.vSize(height);
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomImage(
                    path: KImages.authBg,
                    fit: BoxFit.cover,
                    height: size.height,
                    width: size.width,
                  ),
                  isShowBackButton
                      ? Positioned(
                          top: Utils.vSize(size.height * 0.08),
                          left: Utils.vSize(size.width * 0.06),
                          child: const BackButtonWidget(),
                        )
                      : topChild,
                  Positioned(
                    top: fromTop,
                    child: Container(
                      height: size.height,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Utils.radius(20.0)),
                          topLeft: Radius.circular(Utils.radius(20.0)),
                        ),
                      ),
                      child: Padding(
                        padding: Utils.symmetric(v: 16.0),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_app_bar.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
    required this.title,
    this.height = 80.0,
    this.iconColor = blackColor,
    this.child = const SizedBox(),
    this.isGradientBg = false,
    this.isShowBackButton = true,
  }) : super(key: key);
  final double height;
  final String title;
  final bool isGradientBg;
  final bool isShowBackButton;
  final Color iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: scaffoldBgColor,
      automaticallyImplyLeading: false,
      toolbarHeight: Utils.vSize(height),
      pinned: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(
            title: title,
            isGradientBg: isGradientBg,
            iconColor: iconColor,
            isShowBackButton: isShowBackButton,
          ),
          child,
        ],
      ),
    );
  }
}

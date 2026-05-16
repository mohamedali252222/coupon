import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'custom_image.dart';
import 'custom_text.dart';

class EmptyWidget extends StatelessWidget {
  EmptyWidget({
    super.key,
    this.isSliver = true,
    required this.icon,
    required this.text,
    this.height = 0.0,
  });

  final bool isSliver;
  final String icon;
  final String text;
  double height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    height = size.height * 0.7;
    if (isSliver) {
      return SliverToBoxAdapter(
        child: _buildEmptyWidget(height, icon, text),
      );
    } else {
      return _buildEmptyWidget(height, icon, text);
    }
  }

  Widget _buildEmptyWidget(double height, String icon, String text) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(path: icon),
          Utils.verticalSpace(20.0),
          CustomText(
            text: text,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          )
        ],
      ),
    );
  }
}

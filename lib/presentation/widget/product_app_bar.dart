import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_app_bar.dart';

class UploadProductAppBar extends StatelessWidget {
  const UploadProductAppBar({
    super.key,
    required this.title,
    this.child = const SizedBox.shrink(),
    this.isVariantProduct = false,
  });

  final String title;
  final Widget child;
  final bool isVariantProduct;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Positioned(
      top: Utils.vSize(size.height * 0.06),
      left: Utils.vSize(size.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(
            title: title,
            textColor: whiteColor,
          ),
          isVariantProduct ? child : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

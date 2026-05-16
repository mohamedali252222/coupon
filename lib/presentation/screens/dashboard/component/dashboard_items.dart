import 'package:flutter/material.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: Utils.borderRadius(r: 6.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 84,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              minRadius: 25.0,
              backgroundColor: primaryColor.withOpacity(0.1),
              child: CustomImage(
                path: icon,
                color: primaryColor,
              ),
            ),
            Utils.verticalSpace(6.0),
            CustomText(
              text: title,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: blackColor,
            )
          ],
        ),
      ),
    );
  }
}

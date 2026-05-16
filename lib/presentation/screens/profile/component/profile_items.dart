import 'package:flutter/material.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isVersion = false,
    this.isUnderline = true,
  });

  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool isVersion;
  final bool isUnderline;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.only(bottom: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomImage(
                      path: icon,
                      color: primaryColor,
                    ),
                    Utils.horizontalSpace(10.0),
                    CustomText(
                      text: title,
                      fontSize: 16.0,
                      color: blackColor,
                    )
                  ],
                ),
                isVersion
                    ? const CustomText(
                        text: '4.1.0',
                        fontSize: 16.0,
                        color: primaryColor,
                      )
                    : const SizedBox()
              ],
            ),
            isUnderline
                ? Container(
                    margin: Utils.only(top: 16.0),
                    height: 1.0,
                    color: grayColor.withOpacity(0.2))
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

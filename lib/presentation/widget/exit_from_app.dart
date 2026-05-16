import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constraints.dart';
import '../utils/k_images.dart';
import '../utils/utils.dart';
import 'action_button.dart';
import 'custom_text.dart';
import 'feedback_dialog.dart';

class ExitFromApp extends StatelessWidget {
  const ExitFromApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FeedBackDialog(
      image: KImages.exitIcon,
      bgColor: redColor,
      message: 'Are you sure',
      child: Column(
        children: [
          const CustomText(
            text: 'You want to exit?',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: grayColor,
          ),
          Utils.verticalSpace(20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButton(
                title: 'Yes',
                onTap: () => SystemNavigator.pop(),
                color: redColor,
                textColor: whiteColor,
              ),
              Utils.horizontalSpace(18.0),
              ActionButton(
                title: 'Cancel',
                onTap: () => Navigator.of(context).pop(),
                color: blackColor,
                textColor: whiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

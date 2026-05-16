import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import 'custom_text.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({Key? key, required this.onTap, required this.title})
      : super(key: key);
  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(transparent)),
      child: CustomText(
        text: title,
        fontSize: 20.0,
      ),
    );
  }
}

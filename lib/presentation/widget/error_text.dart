import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import 'custom_text.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
      child: CustomText(
        text: '* $text',
        color: redColor,
        fontSize: 12,
      ),
    );
  }
}

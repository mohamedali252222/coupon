import 'package:flutter/material.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, this.review = 5});

  final int review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(
              review,
              (index) {
                return Icon(
                  Icons.star,
                  color:
                      index == 4 ? grayColor.withOpacity(0.8) : secondaryColor,
                  size: 20.0,
                );
              },
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.reply_all_rounded,
              color: blackColor,
            ),
            label: const CustomText(
              text: 'Reply',
            ),
          ),
        ],
      ),
    );
  }
}

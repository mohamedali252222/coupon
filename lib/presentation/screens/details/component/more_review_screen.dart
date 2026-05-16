import 'package:flutter/material.dart';

import '../../../../data/dummy_data/dummy_data.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_sliver_app_bar.dart';

class MoreReviewScreen extends StatelessWidget {
  const MoreReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
            title: 'Reviews',
            iconColor: whiteColor,
            isGradientBg: true,
          ),
          SliverPadding(
            padding: Utils.symmetric(),
            sliver: SliverList.list(
              children: List.generate(
                comments.length,
                (index) {
                  return const Text('review');
                  // return CommentCard(
                  //   comment: comments[index],
                  //   child: const ReviewWidget(),
                  // );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

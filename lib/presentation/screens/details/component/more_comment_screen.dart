import 'package:flutter/material.dart';

import '../../../../data/models/details/comment/single_comment_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_sliver_app_bar.dart';
import 'comment_card.dart';

class MoreCommentScreen extends StatelessWidget {
  const MoreCommentScreen({super.key, required this.data});

  final List<SingleCommentModel> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
            title: 'Comment',
            iconColor: whiteColor,
            isGradientBg: true,
          ),
          SliverPadding(
            padding: Utils.symmetric(),
            sliver: SliverList.list(
              children: List.generate(
                data.length,
                (index) => CommentCard(comment: data[index]),
              ),
            ),
          )
        ],
      ),
    );
  }
}

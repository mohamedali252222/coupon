import 'package:flutter/material.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/details/comment/single_comment_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.comment,
    this.child = const SizedBox(),
  });

  final SingleCommentModel comment;

  // final DummyComment comment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      margin: Utils.symmetric(v: 10.0, h: 0.0),
      padding: Utils.symmetric(v: 10.0, h: 10.0).copyWith(right: 0.0),
      decoration: BoxDecoration(
        color: grayColor2,
        borderRadius: Utils.borderRadius(),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width * 0.15,
            height: Utils.vSize(60.0),
            alignment: Alignment.topCenter,
            child: ClipOval(
              child: CustomImage(
                path: RemoteUrls.imageUrl(comment.user!.image),
                fit: BoxFit.cover,
                height: Utils.vSize(60.0),
                width: Utils.hSize(size.height * 0.15),
              ),
            ),
          ),
          Container(
            width: size.width * 0.68,
            margin: Utils.only(left: 8.0),
            //color: redColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: comment.name,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      // text: comment.time,
                      text: Utils.convertToAgo(comment.createdAt),
                      fontSize: 14.0,
                      color: grayColor,
                    ),
                  ],
                ),
                CustomText(
                  text: '"${comment.comment}"',
                  color: grayColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  maxLine: 3,
                  height: 1.8,
                  overflow: TextOverflow.ellipsis,
                ),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/details/product_details_model.dart';
import '../../../../../logic/cubit/details/details_cubit.dart';
import '../../../../../logic/cubit/language_code_state.dart';
import '../../../../routes/routes_name.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text.dart';
import '../../../../widget/error_text.dart';
import '../../../../widget/primary_button.dart';
import '../comment_card.dart';

class CommentTab extends StatelessWidget {
  const CommentTab({super.key, required this.comment});

  final ProductDetailsModel comment;

  @override
  Widget build(BuildContext context) {
    final comments = comment.comments!;
    final detailCubit = context.read<DetailsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (comments.data!.isNotEmpty) ...[
          ...List.generate(
            comments.data!.length >= 2 ? 2 : comments.data!.length,
            (index) {
              final item = comments.data![index];
              return CommentCard(comment: item);
            },
          ),
        ] else ...[
          const CustomImage(path: KImages.noComment),
        ],
        comments.data!.length > 2
            ? TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RouteNames.moreCommentScreen),
                child: const CustomText(
                  text: 'See More Comment',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                  textAlign: TextAlign.center,
                ),
              )
            : Utils.verticalSpace(10.0),
        Utils.verticalSpace(10.0),
        Container(
          padding: Utils.symmetric(v: 16.0),
          decoration: BoxDecoration(
            color: grayColor2,
            borderRadius: Utils.borderRadius(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Leave a Comment',
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
              Utils.verticalSpace(10.0),
              BlocBuilder<DetailsCubit, LanguageCodeState>(
                builder: (context, state) {
                  final details = state.detailsState;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: detailCubit.commentController,
                        decoration: InputDecoration(
                          hintText: 'leave a comment',
                          border: OutlineInputBorder(
                            borderRadius: Utils.borderRadius(r: 6.0),
                            borderSide:
                                const BorderSide(color: Color(0xFFE8E8E8)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: Utils.borderRadius(r: 6.0),
                            borderSide:
                                const BorderSide(color: Color(0xFFE8E8E8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: Utils.borderRadius(r: 6.0),
                            borderSide:
                                const BorderSide(color: Color(0xFFE8E8E8)),
                          ),
                          filled: true,
                          fillColor: whiteColor.withOpacity(0.6),
                        ),
                        maxLines: 4,
                      ),
                      if (details is DetailsFormError) ...[
                        if (details.errors.comment.isNotEmpty)
                          ErrorText(text: details.errors.comment.first),
                      ]
                    ],
                  );
                },
              ),
              Utils.verticalSpace(20.0),
              BlocListener<DetailsCubit, LanguageCodeState>(
                  listener: (context, state) {
                    final details = state.detailsState;
                    if (details is PostCommentLoading) {
                      Utils.loadingDialog(context);
                    } else {
                      Utils.closeDialog(context);
                      if (details is PostCommentError) {
                        Utils.errorSnackBar(context, details.message);
                      } else if (details is DetailsSendMessageLoaded) {
                        Utils.showSnackBar(context, details.message);
                        detailCubit.commentController.clear();
                      }
                    }
                  },
                  child: PrimaryButton(
                      text: 'Submit Comment',
                      onPressed: () {
                        Utils.closeKeyBoard(context);
                        final commentBody = {
                          'product_id': comment.product!.id.toString(),
                          'comment': detailCubit.commentController.text,
                        };
                        detailCubit.postComment(commentBody);
                      }))
            ],
          ),
        ),
      ],
    );
  }
}

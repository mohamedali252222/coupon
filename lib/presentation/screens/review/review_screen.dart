import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/models/download/download_model.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../state_packages_name.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_form.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/custom_text.dart';
import '../../widget/custom_text_button.dart';
import '../../widget/error_text.dart';
import '../../widget/loading_widget.dart';
import '../../widget/primary_button.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key, required this.file}) : super(key: key);
  final DownloadItem file;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double initialRating = 3.5;

  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final login = context.read<LoginBloc>();
    final item = widget.file;
    //print(widget.file.product.name);
    return Scaffold(
      backgroundColor: homeBgColor.withOpacity(0.99),
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
            title: 'Review',
            iconColor: whiteColor,
            isGradientBg: true,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              height: Utils.vSize(115.0),
              padding: Utils.symmetric(),
              margin: Utils.symmetric(v: 20.0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        RemoteUrls.imageUrl(item.product!.thumbnailImage)),
                  ),
                  Flexible(
                    child: Padding(
                      padding: Utils.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Utils.verticalSpace(4.0),
                          Flexible(
                            fit: FlexFit.loose,
                            child: CustomText(
                              text: item.product!.productLangFrontEnd!.name,
                              color: blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              maxLine: 2,
                              height: 1.6,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Utils.verticalSpace(2.0),
                          CustomText(
                            text: Utils.formatPrice(
                                context, item.product!.regularPrice),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: Utils.symmetric(),
              child: Column(
                children: [
                  const CustomText(
                    text: 'Rating our product',
                    fontWeight: FontWeight.w700,
                    fontSize: 22.0,
                    color: blackColor,
                  ),
                  Utils.verticalSpace(6.0),
                  const CustomText(
                    text: 'What is your rate?',
                    fontSize: 16.0,
                    color: grayColor,
                  ),
                  Utils.verticalSpace(6.0),
                  RatingBar.builder(
                      itemSize: 30.0,
                      itemBuilder: (context, index) {
                        return const Icon(Icons.star, color: Colors.amber);
                      },
                      glow: false,
                      initialRating: initialRating,
                      allowHalfRating: true,
                      onRatingUpdate: (double? rate) {
                        initialRating = rate!;
                      }),
                  Utils.verticalSpace(16.0),
                  BlocBuilder<DetailsCubit, LanguageCodeState>(
                    builder: (context, state) {
                      final review = state.detailsState;
                      return CustomFormWidget(
                        label: 'Please write product quality',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: reviewController,
                              decoration: const InputDecoration(
                                hintText: 'Type Something',
                              ),
                              maxLines: 4,
                            ),
                            if (review is DetailsFormError) ...[
                              if (review.errors.review.isNotEmpty)
                                ErrorText(text: review.errors.review.first),
                            ]
                          ],
                        ),
                      );
                    },
                  ),
                  Utils.verticalSpace(20.0),
                  BlocConsumer<DetailsCubit, LanguageCodeState>(
                    listener: (context, state) {
                      final review = state.detailsState;
                      if (review is DetailsError) {
                        Utils.errorSnackBar(context, review.message);
                      } else if (review is DetailsSendMessageLoaded) {
                        Utils.showSnackBar(context, review.message);
                        Navigator.of(context).pop();
                        reviewController.clear();
                      }
                    },
                    builder: (context, state) {
                      final review = state.detailsState;
                      if (review is PostReviewLoading) {
                        return const LoadingWidget();
                      }
                      return PrimaryButton(
                          text: 'Submit Review',
                          onPressed: () {
                            Utils.closeKeyBoard(context);
                            final body = {
                              'product_id': item.productId.toString(),
                              'rating': initialRating.toString(),
                              'review': reviewController.text.trim(),
                              'author_id':login.userInformation!.user!.id.toString(),
                            };
                            print(body);
                            context.read<DetailsCubit>().postReview(body);
                          });
                    },
                  ),
                  CustomTextButton(
                      onTap: () => Navigator.of(context).pop(),
                      title: 'Not Now'),
                ],
              ),
            ),
          ]))
        ],
      ),
    );
  }

// Widget buildCustomButton(BuildContext context) {
//   return CustomButton(
//     title: 'Send Feedback',
//     onTap: () => showDialog(
//       context: context,
//       builder: (context) => const FeedBackDialog(
//         image: 'asset/icons/thump.svg',
//         message: 'Thank You !',
//         height: 234.0,
//         child: ReviewDialog(),
//       ),
//     ),
//   );
// }
}

// class ReviewDialog extends StatelessWidget {
//   const ReviewDialog({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(top: 3.0.h, bottom: 26.0.h),
//           child: Text(
//             'Thank you for your valuable feedback',
//             style: GoogleFonts.inter(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14.0.sp,
//                 color: greyColor),
//           ),
//         ),
//         CustomButton(
//             title: 'Go to Home',
//             onTap: () => GoToNext.goToNext(context, RouteNames.mainScreen)),
//       ],
//     );
//   }
// }

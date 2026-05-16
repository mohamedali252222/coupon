import 'package:alas_mart/presentation/widget/product_rating.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/details/product_details_model.dart';
import '../../../../routes/routes_name.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text.dart';
import '../review_card.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({super.key, required this.details});

  final ProductDetailsModel details;

  @override
  Widget build(BuildContext context) {
    final product = details.product!;
    final reviews = details.reviews!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CustomText(
              text: product.totalRating.toStringAsFixed(1),
              fontSize: 40.0,
              fontWeight: FontWeight.w600,
            ),
            Utils.horizontalSpace(10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductRating(rating: product.averageRating.toInt()),
                Utils.verticalSpace(4.0),
                CustomText(
                  text: getReviewText(product.totalRating),
                  fontSize: 16.0,
                  color: const Color(0xFF606060),
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ],
        ),
        if (reviews.data!.isNotEmpty) ...[
          ...List.generate(
            reviews.data!.length >= 2 ? 2 : reviews.data!.length,
            (index) {
              final item = reviews.data![index];
              return ReviewCard(
                comment: item,
                child: ProductRating(rating: item.rating),
              );
            },
          ),
        ] else ...[
          const CustomImage(path: KImages.noReview),
        ],
        reviews.data!.length > 2
            ? TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RouteNames.moreReviewScreen),
                child: const CustomText(
                  text: 'See More Review',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                  textAlign: TextAlign.center,
                ),
              )
            : Utils.verticalSpace(10.0),
      ],
    );
  }

  String getReviewText(int num) {
    if (num >= 2) {
      return "$num Reviews";
    } else {
      return "$num Review";
    }
  }
}

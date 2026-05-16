import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../utils/constraints.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({super.key, required this.rating, this.iconSize = 18.0});

  final int rating;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        initialRating: rating.toDouble(),
        itemCount: 5,
        itemSize: 20.0,
        glow: false,
        tapOnlyMode: true,
        updateOnDrag: false,
        ignoreGestures: true,
        itemBuilder: (context, index) {
          return Icon(
            Icons.star,
            size: iconSize,
            color: secondaryColor,
          );
        },
        onRatingUpdate: (double? rate) {});
  }
}

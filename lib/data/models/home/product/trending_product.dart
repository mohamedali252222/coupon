import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'single_product_model.dart';

class TrendingProductModel extends Equatable {
  final bool visibility;
  final String title;
  final String trendingOfferTitle1;
  final String trendingOfferTitle2;
  final String trendingOfferLink;
  final String trendingOfferImage;
  final String description;
  final List<SingleProductModel>? trendingProducts;

  const TrendingProductModel({
    required this.visibility,
    required this.title,
    required this.trendingOfferTitle1,
    required this.trendingOfferTitle2,
    required this.trendingOfferLink,
    required this.trendingOfferImage,
    required this.description,
    this.trendingProducts,
  });

  TrendingProductModel copyWith({
    bool? visibility,
    String? title,
    String? trendingOfferTitle1,
    String? trendingOfferTitle2,
    String? trendingOfferLink,
    String? trendingOfferImage,
    String? description,
    List<SingleProductModel>? trendingProducts,
  }) {
    return TrendingProductModel(
      visibility: visibility ?? this.visibility,
      title: title ?? this.title,
      trendingOfferTitle1: trendingOfferTitle1 ?? this.trendingOfferTitle1,
      trendingOfferTitle2: trendingOfferTitle2 ?? this.trendingOfferTitle2,
      trendingOfferLink: trendingOfferLink ?? this.trendingOfferLink,
      trendingOfferImage: trendingOfferImage ?? this.trendingOfferImage,
      description: description ?? this.description,
      trendingProducts: trendingProducts ?? this.trendingProducts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'title': title,
      'trending_offer_title1': trendingOfferTitle1,
      'trending_offer_title2': trendingOfferTitle2,
      'trending_offer_link': trendingOfferLink,
      'trending_offer_image': trendingOfferImage,
      'description': description,
      'trending_products': trendingProducts!.map((x) => x.toMap()).toList(),
    };
  }

  factory TrendingProductModel.fromMap(Map<String, dynamic> map) {
    return TrendingProductModel(
      visibility: map['visibility'] ?? true,
      title: map['title'] ?? '',
      trendingOfferTitle1: map['trending_offer_title1'] ?? '',
      trendingOfferTitle2: map['trending_offer_title2'] ?? '',
      trendingOfferLink: map['trending_offer_link'] ?? '',
      trendingOfferImage: map['trending_offer_image'] ?? '',
      description: map['description'] ?? '',
      trendingProducts: map['trending_products'] != null
          ? List<SingleProductModel>.from(
              (map['trending_products'] as List<dynamic>)
                  .map<SingleProductModel?>(
                (x) => SingleProductModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrendingProductModel.fromJson(String source) =>
      TrendingProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      visibility,
      title,
      trendingOfferTitle1,
      trendingOfferTitle2,
      trendingOfferLink,
      trendingOfferImage,
      description,
      trendingProducts!,
    ];
  }
}

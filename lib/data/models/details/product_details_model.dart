import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'comment/comment_model.dart';
import 'product_item_model.dart';
import 'review/review_model.dart';
import 'script_content_model.dart';
import 'variant/variant_model.dart';

class ProductDetailsModel extends Equatable {
  final ProductItemModel? product;
  final List<ProductItemModel>? relatedProducts;
  final List<VariantModel>? variants;
  final VariantModel? firstVariant;
  final CommentModel? comments;
  final ReviewModel? reviews;
  final int totalSale;
  final ScriptContentModel? scriptContent;

  const ProductDetailsModel({
    required this.product,
    required this.relatedProducts,
    required this.variants,
    required this.firstVariant,
    required this.comments,
    required this.reviews,
    required this.totalSale,
    required this.scriptContent,
  });

  ProductDetailsModel copyWith({
    ProductItemModel? product,
    List<ProductItemModel>? relatedProducts,
    List<VariantModel>? variants,
    VariantModel? firstVariant,
    CommentModel? comments,
    ReviewModel? reviews,
    int? totalSale,
    ScriptContentModel? scriptContent,
  }) {
    return ProductDetailsModel(
      product: product ?? this.product,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      variants: variants ?? this.variants,
      firstVariant: firstVariant ?? this.firstVariant,
      comments: comments ?? this.comments,
      reviews: reviews ?? this.reviews,
      totalSale: totalSale ?? this.totalSale,
      scriptContent: scriptContent ?? this.scriptContent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product!.toMap(),
      'related_products': relatedProducts!.map((x) => x.toMap()).toList(),
      'variants': variants!.map((x) => x.toMap()).toList(),
      'first_variant': firstVariant!.toMap(),
      'productComments': comments!.toMap(),
      'productReviews': reviews!.toMap(),
      'total_sale': totalSale,
      'script_content': scriptContent!.toMap(),
    };
  }

  factory ProductDetailsModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailsModel(
      product: map['product'] != null
          ? ProductItemModel.fromMap(map['product'] as Map<String, dynamic>)
          : null,
      relatedProducts: map['related_products'] != null
          ? List<ProductItemModel>.from(
              (map['related_products'] as List<dynamic>).map<ProductItemModel>(
                (x) => ProductItemModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      variants: map['variants'] != null
          ? List<VariantModel>.from(
              (map['variants'] as List<dynamic>).map<VariantModel>(
                (x) => VariantModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      firstVariant: map['first_variant'] != null
          ? VariantModel.fromMap(map['first_variant'] as Map<String, dynamic>)
          : null,
      comments: map['productComments'] != null
          ? CommentModel.fromMap(map['productComments'] as Map<String, dynamic>)
          : null,
      reviews: map['productReviews'] != null
          ? ReviewModel.fromMap(map['productReviews'] as Map<String, dynamic>)
          : null,
      totalSale: map['total_sale'] != null
          ? int.parse(map['total_sale'].toString())
          : 0,
      scriptContent: map['script_content'] != null
          ? ScriptContentModel.fromMap(
              map['script_content'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetailsModel.fromJson(String source) =>
      ProductDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      product!,
      relatedProducts!,
      variants!,
      //firstVariant!,
      comments!,
      reviews!,
      totalSale,
      scriptContent!,
    ];
  }
}

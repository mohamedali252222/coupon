import 'dart:convert';

import 'package:equatable/equatable.dart';


class CartItemModel extends Equatable {
  final int id;
  final int userId;
  final int productId;
  final String productName;
  final double price;
  final int variantId;
  final String variantName;
  final String categoryName;
  final String productType;
  final String priceType;
  final String image;
  final int authorId;
  final String authorName;
  final String productSlug;
  final String createdAt;
  final String updatedAt;

  const CartItemModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.price,
    required this.variantId,
    required this.variantName,
    required this.categoryName,
    required this.productType,
    required this.priceType,
    required this.image,
    required this.authorId,
    required this.authorName,
    required this.productSlug,
    required this.createdAt,
    required this.updatedAt,
  });

  CartItemModel copyWith({
    int? id,
    int? userId,
    int? productId,
    String? productName,
    double? price,
    int? variantId,
    String? variantName,
    String? categoryName,
    String? productType,
    String? priceType,
    String? image,
    int? authorId,
    String? authorName,
    String? productSlug,
    String? createdAt,
    String? updatedAt,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
      categoryName: categoryName ?? this.categoryName,
      productType: productType ?? this.productType,
      priceType: priceType ?? this.priceType,
      image: image ?? this.image,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      productSlug: productSlug ?? this.productSlug,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, String>{};
    result.addAll({'product_name': productName});
    if (variantId != 0) {
      result.addAll({'variant_id': variantId.toString()});
      result.addAll({'variant_name': variantName});
    }
    result.addAll({'price': price.toString()});
    result.addAll({'category_name': categoryName});
    result.addAll({'product_type': productType});
    if (productType == 'script') {
      result.addAll({'regular_price': productName});
      result.addAll({'extend_price': productName});
    }
    result.addAll({'price_type': priceType});
    result.addAll({'image': image});
    result.addAll({'author_id': authorId.toString()});
    result.addAll({'author_name': authorName});
    result.addAll({'product_slug': productSlug});

    return result;
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as int,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      productName: map['product_name'] ?? '',
      price: map['price'] != null ? double.parse(map['price'].toString()) : 0.0,
      variantId: map['variant_id'] != null
          ? int.parse(map['variant_id'].toString())
          : 0,
      variantName: map['variant_name'] ?? '',
      categoryName: map['category_name'] ?? '',
      productType: map['product_type'] ?? '',
      priceType: map['price_type'] ?? '',
      image: map['image'] ?? '',
      authorId:
          map['author_id'] != null ? int.parse(map['author_id'].toString()) : 0,
      authorName: map['author_name'] ?? '',
      productSlug: map['product_slug'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      productId,
      productName,
      price,
      variantId,
      variantName,
      categoryName,
      productType,
      priceType,
      image,
      authorId,
      authorName,
      productSlug,
      createdAt,
      updatedAt,
    ];
  }
}

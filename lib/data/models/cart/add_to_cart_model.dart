// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddToCartModel extends Equatable {
  final int productId;
  final int variantId;
  final String productType;
  final String priceType;

  const AddToCartModel({
    this.variantId = 0,
    required this.productId,
    required this.productType,
    this.priceType = "",
  });

  AddToCartModel copyWith({
    int? variantId,
    int? productId,
    String? productType,
    String? priceType,
  }) {
    return AddToCartModel(
      variantId: variantId ?? this.variantId,
      productId: productId ?? this.productId,
      productType: productType ?? this.productType,
      priceType: priceType ?? this.priceType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, String>{};

    result.addAll({'product_id': productId.toString()});
    result.addAll({'product_type': productType});
    if (productType == 'script') {
      result.addAll({'price_type': priceType});
    } else {
      result.addAll({'variant_id': variantId.toString()});
    }

    return result;
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      variantId: map['variant_id'] as int,
      productId: map['product_id'] as int,
      productType: map['product_type'] as String,
      priceType: map['price_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCartModel.fromJson(String source) =>
      AddToCartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      variantId,
      productId,
      productType,
      priceType,
    ];
  }
}

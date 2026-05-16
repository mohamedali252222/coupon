import 'dart:convert';

import 'package:equatable/equatable.dart';

class VariantModel extends Equatable {
  final int id;
  final int productId;
  final String variantName;
  final double price;
  final String fileName;
  final String createdAt;
  final String updatedAt;

  const VariantModel({
    required this.id,
    required this.productId,
    required this.variantName,
    required this.price,
    required this.fileName,
    required this.createdAt,
    required this.updatedAt,
  });

  VariantModel copyWith({
    int? id,
    int? productId,
    String? variantName,
    double? price,
    String? fileName,
    String? createdAt,
    String? updatedAt,
  }) {
    return VariantModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      variantName: variantName ?? this.variantName,
      price: price ?? this.price,
      fileName: fileName ?? this.fileName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'variant_name': variantName,
      'price': price,
      'file_name': fileName,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory VariantModel.fromMap(Map<String, dynamic> map) {
    return VariantModel(
      id: map['id'] ?? 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      variantName: map['variant_name'] ?? '',
      price: map['price'] != null ? double.parse(map['price'].toString()) : 0.0,
      fileName: map['file_name'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VariantModel.fromJson(String source) =>
      VariantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      variantName,
      price,
      fileName,
      createdAt,
      updatedAt,
    ];
  }
}

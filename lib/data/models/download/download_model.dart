// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../details/product_item_model.dart';

class DownloadItem extends Equatable {
  final int id;
  final int orderId;
  final int productId;
  final int authorId;
  final int userId;
  final String productType;
  final String priceType;
  final int variantId;
  final String variantName;
  final int price;
  final int qty;
  final String createdAt;
  final String updatedAt;
  final ProductItemModel? product;
  final Variant? variant;

  const DownloadItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.authorId,
    required this.userId,
    required this.productType,
    required this.priceType,
    required this.variantId,
    required this.variantName,
    required this.price,
    required this.qty,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.variant,
  });

  DownloadItem copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? authorId,
    int? userId,
    String? productType,
    String? priceType,
    int? variantId,
    String? variantName,
    int? price,
    int? qty,
    String? createdAt,
    String? updatedAt,
    ProductItemModel? product,
    Variant? variant,
  }) {
    return DownloadItem(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      authorId: authorId ?? this.authorId,
      userId: userId ?? this.userId,
      productType: productType ?? this.productType,
      priceType: priceType ?? this.priceType,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
      price: price ?? this.price,
      qty: qty ?? this.qty,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product,
      variant: variant ?? this.variant,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'author_id': authorId,
      'user_id': userId,
      'product_type': productType,
      'price_type': priceType,
      'variant_id': variantId,
      'variant_name': variantName,
      'price': price,
      'qty': qty,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'product': product!.toMap(),
      'variant': variant!.toMap(),
    };
  }

  factory DownloadItem.fromMap(Map<String, dynamic> map) {
    return DownloadItem(
      id: map['id'] as int,
      orderId:
          map['order_id'] != null ? int.parse(map['order_id'].toString()) : 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      authorId:
          map['author_id'] != null ? int.parse(map['author_id'].toString()) : 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      productType: map['product_type'] ?? '',
      priceType: map['price_type'] ?? '',
      variantId: map['variant_id'] != null
          ? int.parse(map['variant_id'].toString())
          : 0,
      variantName: map['variant_name'] ?? '',
      price: map['price'] != null ? int.parse(map['price'].toString()) : 0,
      qty: map['qty'] != null ? int.parse(map['qty'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      product: map['product'] != null
          ? ProductItemModel.fromMap(map['product'] as Map<String, dynamic>)
          : null,
      variant: map['variant'] != null
          ? Variant.fromMap(map['variant'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DownloadItem.fromJson(String source) =>
      DownloadItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderId,
      productId,
      authorId,
      userId,
      productType,
      priceType,
      variantId,
      variantName,
      price,
      qty,
      createdAt,
      updatedAt,
      product!,
      variant!,
    ];
  }
}

class Variant extends Equatable {
  final int id;
  final int productId;
  final String variantName;
  final String price;
  final String fileName;
  final String createdAt;
  final String updatedAt;

  const Variant({
    required this.id,
    required this.productId,
    required this.variantName,
    required this.price,
    required this.fileName,
    required this.createdAt,
    required this.updatedAt,
  });

  Variant copyWith({
    int? id,
    int? productId,
    String? variantName,
    String? price,
    String? fileName,
    String? createdAt,
    String? updatedAt,
  }) {
    return Variant(
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

  factory Variant.fromMap(Map<String, dynamic> map) {
    return Variant(
      id: map['id'] ?? 0,
      productId: map['product_id'] ?? 0,
      variantName: map['variant_name'] ?? '',
      price: map['price'] ?? '',
      fileName: map['file_name'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Variant.fromJson(String source) =>
      Variant.fromMap(json.decode(source) as Map<String, dynamic>);

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




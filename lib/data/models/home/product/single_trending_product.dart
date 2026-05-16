// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SingleTrendingProduct extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String productType;
  final String thumbnailImage;
  final String productIcon;
  final double regularPrice;
  final int status;
  final int approveByAdmin;
  final int popularItem;
  final int totalSold;

  const SingleTrendingProduct({
    required this.id,
    required this.name,
    required this.slug,
    required this.productType,
    required this.thumbnailImage,
    required this.productIcon,
    required this.regularPrice,
    required this.status,
    required this.approveByAdmin,
    required this.popularItem,
    required this.totalSold,
  });

  SingleTrendingProduct copyWith({
    int? id,
    String? name,
    String? slug,
    String? productType,
    String? thumbnailImage,
    String? productIcon,
    double? regularPrice,
    int? status,
    int? approveByAdmin,
    int? popularItem,
    int? totalSold,
  }) {
    return SingleTrendingProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      productType: productType ?? this.productType,
      thumbnailImage: thumbnailImage ?? this.thumbnailImage,
      productIcon: productIcon ?? this.productIcon,
      regularPrice: regularPrice ?? this.regularPrice,
      status: status ?? this.status,
      approveByAdmin: approveByAdmin ?? this.approveByAdmin,
      popularItem: popularItem ?? this.popularItem,
      totalSold: totalSold ?? this.totalSold,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'product_type': productType,
      'thumbnail_image': thumbnailImage,
      'product_icon': productIcon,
      'regular_price': regularPrice,
      'status': status,
      'approve_by_admin': approveByAdmin,
      'popular_item': popularItem,
      'totalSold': totalSold,
    };
  }

  factory SingleTrendingProduct.fromMap(Map<String, dynamic> map) {
    return SingleTrendingProduct(
      id: map['id'] as int,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      productType: map['product_type'] ?? '',
      thumbnailImage: map['thumbnail_image'] ?? '',
      productIcon: map['product_icon'] ?? '',
      regularPrice: map['regular_price'] != null
          ? double.parse(map['regular_price'].toString())
          : 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      approveByAdmin: map['approve_by_admin'] != null
          ? int.parse(map['approve_by_admin'].toString())
          : 0,
      popularItem: map['popular_item'] != null
          ? int.parse(map['popular_item'].toString())
          : 0,
      totalSold:
          map['totalSold'] != null ? int.parse(map['totalSold'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleTrendingProduct.fromJson(String source) =>
      SingleTrendingProduct.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      productType,
      thumbnailImage,
      productIcon,
      regularPrice,
      status,
      approveByAdmin,
      popularItem,
      totalSold,
    ];
  }
}

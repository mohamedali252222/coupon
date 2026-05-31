import 'dart:convert';

import 'package:equatable/equatable.dart';

class OfferCouponModel extends Equatable {
  final int id;
  final int? authorId;
  final int? categoryId;
  final String title;
  final String? description;
  final String couponCode;
  final String storeName;
  final String? storeLogo;
  final String? storeUrl;
  final String discountType;
  final String? discountValue;
  final String? originalPrice;
  final String? priceAfterDiscount;
  final String? thumbnailImage;
  final String? expiryDate; // نص زي ما جاي من الـ API
  final int? maxUses;
  final int usedCount;
  final int totalSold;
  final String? tags;
  final int status;

  const OfferCouponModel({
    required this.id,
    required this.authorId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.couponCode,
    required this.storeName,
    required this.storeLogo,
    required this.storeUrl,
    required this.discountType,
    required this.discountValue,
    required this.originalPrice,
    required this.priceAfterDiscount,
    required this.thumbnailImage,
    required this.expiryDate,
    required this.maxUses,
    required this.usedCount,
    required this.totalSold,
    required this.tags,
    required this.status,
  });

  OfferCouponModel copyWith({
    int? id,
    int? authorId,
    int? categoryId,
    String? title,
    String? description,
    String? couponCode,
    String? storeName,
    String? storeLogo,
    String? storeUrl,
    String? discountType,
    String? discountValue,
    String? originalPrice,
    String? priceAfterDiscount,
    String? thumbnailImage,
    String? expiryDate,
    int? maxUses,
    int? usedCount,
    int? totalSold,
    String? tags,
    int? status,
  }) {
    return OfferCouponModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      couponCode: couponCode ?? this.couponCode,
      storeName: storeName ?? this.storeName,
      storeLogo: storeLogo ?? this.storeLogo,
      storeUrl: storeUrl ?? this.storeUrl,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      originalPrice: originalPrice ?? this.originalPrice,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      thumbnailImage: thumbnailImage ?? this.thumbnailImage,
      expiryDate: expiryDate ?? this.expiryDate,
      maxUses: maxUses ?? this.maxUses,
      usedCount: usedCount ?? this.usedCount,
      totalSold: totalSold ?? this.totalSold,
      tags: tags ?? this.tags,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author_id': authorId,
      'category_id': categoryId,
      'title': title,
      'description': description,
      'coupon_code': couponCode,
      'store_name': storeName,
      'store_logo': storeLogo,
      'store_url': storeUrl,
      'discount_type': discountType,
      'discount_value': discountValue,
      'original_price': originalPrice,
      'price_after_discount': priceAfterDiscount,
      'thumbnail_image': thumbnailImage,
      'expiry_date': expiryDate,
      'max_uses': maxUses,
      'used_count': usedCount,
      'total_sold': totalSold,
      'tags': tags,
      'status': status,
    };
  }

  factory OfferCouponModel.fromMap(Map<String, dynamic> map) {
    return OfferCouponModel(
      id: map['id'] ?? 0,
      authorId: map['author_id'],
      categoryId: map['category_id'],
      title: map['title'] ?? '',
      description: map['description'],
      couponCode: map['coupon_code'] ?? '',
      storeName: map['store_name'] ?? '',
      storeLogo: map['store_logo'],
      storeUrl: map['store_url'],
      discountType: map['discount_type'] ?? 'percentage',
      discountValue: map['discount_value']?.toString(),
      originalPrice: map['original_price']?.toString(),
      priceAfterDiscount: map['price_after_discount']?.toString(),
      thumbnailImage: map['thumbnail_image'],
      expiryDate: map['expiry_date']?.toString(),
      maxUses: map['max_uses'],
      usedCount: map['used_count'] ?? 0,
      totalSold: map['total_sold'] ?? 0,
      tags: map['tags'],
      status: map['status'] ?? 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferCouponModel.fromJson(String source) =>
      OfferCouponModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        id,
        authorId,
        categoryId,
        title,
        description,
        couponCode,
        storeName,
        storeLogo,
        storeUrl,
        discountType,
        discountValue,
        originalPrice,
        priceAfterDiscount,
        thumbnailImage,
        expiryDate,
        maxUses,
        usedCount,
        totalSold,
        tags,
        status,
      ];
}
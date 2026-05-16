import 'dart:convert';

import 'package:equatable/equatable.dart';

class CouponDto extends Equatable {
  final String couponName;
  final int discount;
  final String message;

  const CouponDto({
    required this.couponName,
    required this.discount,
    required this.message,
  });

  CouponDto copyWith({
    String? couponName,
    int? discount,
    String? message,
  }) {
    return CouponDto(
      couponName: couponName ?? this.couponName,
      discount: discount ?? this.discount,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coupon_name': couponName,
      'coupon_discount': discount,
      'message': message,
    };
  }

  factory CouponDto.fromMap(Map<String, dynamic> map) {
    return CouponDto(
      couponName: map['coupon_name'] as String,
      discount: int.parse(map['coupon_discount'].toString()),
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponDto.fromJson(String source) =>
      CouponDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      couponName,
      discount,
      message,
    ];
  }
}

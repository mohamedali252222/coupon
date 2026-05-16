// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SslcommerzDto extends Equatable {
  final int id;
  final int status;
  final String storeId;
  final String storePassword;
  final String countryCode;
  final String currencyCode;
  final int currencyRate;
  final String image;
  final String createdAt;
  final String updatedAt;
  const SslcommerzDto({
    required this.id,
    required this.status,
    required this.storeId,
    required this.storePassword,
    required this.countryCode,
    required this.currencyCode,
    required this.currencyRate,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  SslcommerzDto copyWith({
    int? id,
    int? status,
    String? storeId,
    String? storePassword,
    String? countryCode,
    String? currencyCode,
    int? currencyRate,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    return SslcommerzDto(
      id: id ?? this.id,
      status: status ?? this.status,
      storeId: storeId ?? this.storeId,
      storePassword: storePassword ?? this.storePassword,
      countryCode: countryCode ?? this.countryCode,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyRate: currencyRate ?? this.currencyRate,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'store_id': storeId,
      'store_password': storePassword,
      'country_code': countryCode,
      'currency_code': currencyCode,
      'currency_rate': currencyRate,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SslcommerzDto.fromMap(Map<String, dynamic> map) {
    return SslcommerzDto(
      id: map['id'] as int,
      status: map['status'] as int,
      storeId: map['store_id'] as String,
      storePassword: map['store_password'] as String,
      countryCode: map['country_code'] as String,
      currencyCode: map['currency_code'] as String,
      currencyRate: map['currency_rate'] as int,
      image: map['image'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SslcommerzDto.fromJson(String source) =>
      SslcommerzDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      status,
      storeId,
      storePassword,
      countryCode,
      currencyCode,
      currencyRate,
      image,
      createdAt,
      updatedAt,
    ];
  }
}

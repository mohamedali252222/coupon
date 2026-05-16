import 'dart:convert';

import 'package:equatable/equatable.dart';

class SslPaymentModel extends Equatable {
  final int id;
  final int status;
  final String storeId;
  final String storePassword;
  final String countryCode;
  final String currencyCode;
  final double currencyRate;
  final String image;
  final String createdAt;
  final String updatedAt;
  final int currencyId;

  const SslPaymentModel({
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
    required this.currencyId,
  });

  SslPaymentModel copyWith({
    int? id,
    int? status,
    String? storeId,
    String? storePassword,
    String? countryCode,
    String? currencyCode,
    double? currencyRate,
    String? image,
    String? createdAt,
    String? updatedAt,
    int? currencyId,
  }) {
    return SslPaymentModel(
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
      currencyId: currencyId ?? this.currencyId,
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
      'currency_id': currencyId,
    };
  }

  factory SslPaymentModel.fromMap(Map<String, dynamic> map) {
    return SslPaymentModel(
      id: map['id'] ?? 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      storeId: map['store_id'] ?? '',
      storePassword: map['store_password'] ?? '',
      countryCode: map['country_code'] ?? '',
      currencyCode: map['currency_code'] ?? '',
      currencyRate: map['currency_rate'] != null
          ? double.parse(map['currency_rate'].toString())
          : 0,
      image: map['image'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      currencyId: map['currency_id'] != null
          ? int.parse(map['currency_id'].toString())
          : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SslPaymentModel.fromJson(String source) =>
      SslPaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
      currencyId,
    ];
  }
}

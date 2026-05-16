import 'dart:convert';

import 'package:equatable/equatable.dart';

class WithdrawModel extends Equatable {
  final int id;
  final int userId;
  final String method;
  final double totalAmount;
  final double withdrawAmount;
  final double withdrawCharge;
  final String accountInfo;
  final String approvedDate;
  final int status;
  final String createdAt;
  final String updatedAt;

  const WithdrawModel({
    required this.id,
    required this.userId,
    required this.approvedDate,
    required this.method,
    required this.totalAmount,
    required this.withdrawAmount,
    required this.withdrawCharge,
    required this.accountInfo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  WithdrawModel copyWith({
    int? id,
    int? userId,
    String? method,
    double? totalAmount,
    double? withdrawAmount,
    double? withdrawCharge,
    String? accountInfo,
    String? approvedDate,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return WithdrawModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      approvedDate: approvedDate ?? this.approvedDate,
      method: method ?? this.method,
      totalAmount: totalAmount ?? this.totalAmount,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      withdrawCharge: withdrawCharge ?? this.withdrawCharge,
      accountInfo: accountInfo ?? this.accountInfo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': id,
      'method': method,
      'approved_date': approvedDate,
      'total_amount': totalAmount,
      'withdraw_amount': withdrawAmount,
      'withdraw_charge': withdrawCharge,
      'account_info': accountInfo,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // "id": 1,
  // "name": "Bank Payment",
  // "min_amount": 10,
  // "max_amount": 20,
  // "withdraw_charge": 1,
  // "description": "<p>Bank Name: Your bank name</p><p><span style=\"background-color: transparent;\">Account Number:&nbsp; Your bank account number</span></p><p>Routing Number: Your bank routing number</p><p>Branch: Your bank branch name</p>",
  // "status": 1,
  // "created_at": "2022-10-07T17:15:37.000000Z",
  // "updated_at": "2022-10-07T17:15:37.000000Z"

  factory WithdrawModel.fromMap(Map<String, dynamic> json) {
    return WithdrawModel(
      id: json['id'] ?? 0,
      userId:
          json['user_id'] != null ? int.parse(json['user_id'].toString()) : 0,
      approvedDate: json['approved_date'] ?? '',
      method: json['method'] ?? '',
      totalAmount: json['total_amount'] != null
          ? double.parse(json['total_amount'].toString())
          : 0,
      withdrawAmount: json['withdraw_amount'] != null
          ? double.parse(json['withdraw_amount'].toString())
          : 0,
      withdrawCharge: json['withdraw_charge'] != null
          ? double.parse(json['withdraw_charge'].toString())
          : 0,
      accountInfo: json['account_info'] ?? '',
      status: json['status'] != null ? int.parse(json['status'].toString()) : 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawModel.fromJson(String source) =>
      WithdrawModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      approvedDate,
      method,
      totalAmount,
      withdrawAmount,
      withdrawCharge,
      accountInfo,
      status,
      createdAt,
      updatedAt,
    ];
  }
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'method_model.dart';
import 'withdraw_model.dart';

class SellerWithdrawInfo extends Equatable {
  final List<WithdrawModel> withdraws;
  final List<MethodModel> withdrawMethods;
  final double totalBalance;
  final double totalWithdraw;
  final double currentBalance;
  const SellerWithdrawInfo({
    required this.withdraws,
    required this.withdrawMethods,
    required this.totalBalance,
    required this.totalWithdraw,
    required this.currentBalance,
  });

  SellerWithdrawInfo copyWith({
    List<WithdrawModel>? withdraws,
    List<MethodModel>? withdrawMethods,
    double? totalBalance,
    double? totalWithdraw,
    double? currentBalance,
  }) {
    return SellerWithdrawInfo(
      withdraws: withdraws ?? this.withdraws,
      withdrawMethods: withdrawMethods ?? this.withdrawMethods,
      totalBalance: totalBalance ?? this.totalBalance,
      totalWithdraw: totalWithdraw ?? this.totalWithdraw,
      currentBalance: currentBalance ?? this.currentBalance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'withdraws': withdraws.map((x) => x.toMap()).toList(),
      'withdraw_methods': withdrawMethods.map((x) => x.toMap()).toList(),
      'total_balance': totalBalance,
      'total_withdraw': totalWithdraw,
      'current_balance': currentBalance,
    };
  }

  factory SellerWithdrawInfo.fromMap(Map<String, dynamic> map) {
    return SellerWithdrawInfo(
      withdraws: List<WithdrawModel>.from(
        (map['withdraws'] as List<dynamic>).map<WithdrawModel>(
          (x) => WithdrawModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      withdrawMethods: List<MethodModel>.from(
        (map['withdraw_methods'] as List<dynamic>).map<MethodModel>(
          (x) => MethodModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalBalance: map['total_balance'] != null
          ? double.parse(map['total_balance'].toString())
          : 0,
      totalWithdraw: map['total_withdraw'] != null
          ? double.parse(map['total_withdraw'].toString())
          : 0,
      currentBalance: map['current_balance'] != null
          ? double.parse(map['current_balance'].toString())
          : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerWithdrawInfo.fromJson(String source) =>
      SellerWithdrawInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      withdraws,
      withdrawMethods,
      totalBalance,
      totalWithdraw,
      currentBalance,
    ];
  }
}

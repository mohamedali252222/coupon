import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'bank_payment_model.dart';
import 'flutterwave_model.dart';
import 'instamojo_model.dart';
import 'molli_paystack_model.dart';
import 'paypal_model.dart';
import 'razorpay_model.dart';
import 'ssl_payment_model.dart';
import 'stripe_model.dart';

class PaymentModel extends Equatable {
  //final UserProfileModel? user;
  final BankPayment? bankPayment;
  final FlutterWavePayment? flutterWave;
  final InstamojoPayment? instamojo;
  final MolliPayStackPayment? molliPayStack;
  final MolliPayStackPayment? paystack;
  final PayPalPayment? payPal;
  final RazorPayPayment? razorPay;
  final StripePayment? stripe;
  final SslPaymentModel? sslcommerz;

  const PaymentModel({
    //this.user,
    required this.bankPayment,
    required this.flutterWave,
    required this.instamojo,
    required this.molliPayStack,
    required this.paystack,
    required this.payPal,
    required this.razorPay,
    required this.stripe,
    required this.sslcommerz,
  });

  PaymentModel copyWith({
    //UserProfileModel? user,
    BankPayment? bankPayment,
    FlutterWavePayment? flutterWave,
    InstamojoPayment? instamojo,
    MolliPayStackPayment? molliPayStack,
    MolliPayStackPayment? paystack,
    PayPalPayment? payPal,
    RazorPayPayment? razorPay,
    StripePayment? stripe,
    SslPaymentModel? sslcommerz,
  }) {
    return PaymentModel(
      //user: user ?? this.user,
      bankPayment: bankPayment ?? this.bankPayment,
      flutterWave: flutterWave ?? this.flutterWave,
      instamojo: instamojo ?? this.instamojo,
      molliPayStack: molliPayStack ?? this.molliPayStack,
      paystack: paystack ?? this.paystack,
      payPal: payPal ?? this.payPal,
      razorPay: razorPay ?? this.razorPay,
      stripe: stripe ?? this.stripe,
      sslcommerz: sslcommerz ?? this.sslcommerz,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      //'user': user!.toMap(),
      'bankPayment': bankPayment!.toMap(),
      'flutterwave': flutterWave!.toMap(),
      'instamojo': instamojo!.toMap(),
      'mollie': molliPayStack!.toMap(),
      'paystack': paystack!.toMap(),
      'paypal': payPal!.toMap(),
      'razorpay': razorPay!.toMap(),
      'stripe': stripe!.toMap(),
      'sslcommerz': sslcommerz!.toMap(),
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      // user: map['user'] != null
      //     ? UserProfileModel.fromMap(map['user'] as Map<String, dynamic>)
      //     : null,
      bankPayment: map['bankPayment'] != null
          ? BankPayment.fromMap(map['bankPayment'] as Map<String, dynamic>)
          : null,
      flutterWave: map['flutterwave'] != null
          ? FlutterWavePayment.fromMap(
              map['flutterwave'] as Map<String, dynamic>)
          : null,
      instamojo: map['instamojo'] != null
          ? InstamojoPayment.fromMap(map['instamojo'] as Map<String, dynamic>)
          : null,
      molliPayStack: map['mollie'] != null
          ? MolliPayStackPayment.fromMap(map['mollie'] as Map<String, dynamic>)
          : null,
      paystack: map['paystack'] != null
          ? MolliPayStackPayment.fromMap(
              map['paystack'] as Map<String, dynamic>)
          : null,
      payPal: map['paypal'] != null
          ? PayPalPayment.fromMap(map['paypal'] as Map<String, dynamic>)
          : null,
      razorPay: map['razorpay'] != null
          ? RazorPayPayment.fromMap(map['razorpay'] as Map<String, dynamic>)
          : null,
      stripe: map['stripe'] != null
          ? StripePayment.fromMap(map['stripe'] as Map<String, dynamic>)
          : null,
      sslcommerz: map['sslcommerz'] != null
          ? SslPaymentModel.fromMap(map['sslcommerz'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      //user!,
      bankPayment!,
      flutterWave!,
      instamojo!,
      molliPayStack!,
      paystack!,
      payPal!,
      razorPay!,
      stripe!,
      sslcommerz!,
    ];
  }
}

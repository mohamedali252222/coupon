part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();

  @override
  List<Object> get props => [];
}

class PaymentStateInfoLoading extends PaymentState {}

class PaymentStateInfoError extends PaymentState {
  final String message;
  final int statusCode;

  const PaymentStateInfoError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class PaymentStateInfoLoaded extends PaymentState {
  final PaymentModel payment;

  const PaymentStateInfoLoaded(this.payment);

  @override
  List<Object> get props => [payment];
}

class PaymentStateFormError extends PaymentState {
  final Errors errors;

  const PaymentStateFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

class BankPaymentLoaded extends PaymentState {
  final String message;

  const BankPaymentLoaded(this.message);

  @override
  List<Object> get props => [message];
}

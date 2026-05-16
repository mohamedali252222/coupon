part of 'seller_withdraw_cubit.dart';

class SellerWithdrawState extends Equatable {
  const SellerWithdrawState();

  @override
  List<Object> get props => [];
}

class SellerWithdrawInitial extends SellerWithdrawState {
  const SellerWithdrawInitial();
  @override
  List<Object> get props => [];
}

class SellerWithdralLoading extends SellerWithdrawState {}

class SellerWithdrawLoaded extends SellerWithdrawState {
  final SellerWithdrawInfo sellerWithdrawInfo;

  const SellerWithdrawLoaded(this.sellerWithdrawInfo);

  @override
  List<Object> get props => [sellerWithdrawInfo];
}

class SellerWithdrawError extends SellerWithdrawState {
  final String message;
  final int statusCode;

  const SellerWithdrawError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

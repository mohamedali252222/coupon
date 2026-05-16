part of 'add_to_cart_cubit.dart';

abstract class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object> get props => [];
}

class AddToCartStateInitial extends AddToCartState {
  const AddToCartStateInitial();
}

class AddToCartStateLoading extends AddToCartState {
  const AddToCartStateLoading();
}

class ApplyStateLoading extends AddToCartState {
  const ApplyStateLoading();
}

class AddToCartStateError extends AddToCartState {
  final String message;
  final int statusCode;

  const AddToCartStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class ApplyStateError extends AddToCartState {
  final String message;
  final int statusCode;

  const ApplyStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class AddToCartStateAdded extends AddToCartState {
  final String message;

  const AddToCartStateAdded(this.message);

  @override
  List<Object> get props => [message];
}

class CouponDataLoaded extends AddToCartState {
  final CouponDto couponDto;

  const CouponDataLoaded(this.couponDto);

  @override
  List<Object> get props => [couponDto];
}

class RemoveCartItem extends AddToCartState {
  final String message;

  const RemoveCartItem(this.message);

  @override
  List<Object> get props => [message];
}

class TotalCartItem extends AddToCartState {
  final int value;

  const TotalCartItem(this.value);

  @override
  List<Object> get props => [value];
}

part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartItemRemoving extends CartState {}

class CartLoaded extends CartState {
  final CartModel cartModel;

  const CartLoaded(this.cartModel);

  @override
  List<Object> get props => [cartModel];
}

class CartError extends CartState {
  final String message;
  final int statusCode;

  const CartError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CartRemoveError extends CartState {
  final String message;
  final int statusCode;

  const CartRemoveError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CartRemoved extends CartState {
  final String message;

  const CartRemoved(this.message);

  @override
  List<Object> get props => [message];
}

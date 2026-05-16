part of 'wishlist_cubit.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();

  @override
  List<Object> get props => [];
}

class WishlistLoading extends WishlistState {}

class WishlistError extends WishlistState {
  const WishlistError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class WishlistShowError extends WishlistState {
  const WishlistShowError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class WishlistLoaded extends WishlistState {
  final List<WishlistModel> wishListData;

  const WishlistLoaded({required this.wishListData});

  @override
  List<Object> get props => [wishListData];
}

class WishItemDeleteSuccess extends WishlistState {
  const WishItemDeleteSuccess(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class WishListStateSuccess extends WishlistState {
  final String message;

  const WishListStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

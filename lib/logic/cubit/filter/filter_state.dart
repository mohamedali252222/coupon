part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {
  const FilterInitial();
}

class FilterStateLoading extends FilterState {}

class FilterStateError extends FilterState {
  final String message;
  final int statusCode;

  const FilterStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class FilterProductByNameLoaded extends FilterState {
  final SearchResponseModel product;

  const FilterProductByNameLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class ProductListLoaded extends FilterState {
  final SearchResponseModel product;

  const ProductListLoaded(this.product);

  @override
  List<Object> get props => [product];
}

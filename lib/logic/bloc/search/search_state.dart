part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {}

class SearchMorePropertyLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductItemModel> products;

  const SearchLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class SearchMorePropertyLoaded extends SearchState {
  final List<ProductItemModel> property;

  const SearchMorePropertyLoaded(this.property);

  @override
  List<Object> get props => [property];
}

class SearchError extends SearchState {
  final String message;
  final int statusCode;

  const SearchError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class SearchMorePropertyError extends SearchState {
  final String message;
  final int statusCode;

  const SearchMorePropertyError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

part of 'update_cubit.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object> get props => [];
}

class UpdateInitial extends UpdateState {
  const UpdateInitial();

  @override
  List<Object> get props => [];
}

class UpdateEditProductLoading extends UpdateState {}

class UpdateEditProductUpdating extends UpdateState {}

class UpdateEditProductLoaded extends UpdateState {
  final EditProductModel editProduct;

  const UpdateEditProductLoaded(this.editProduct);

  @override
  List<Object> get props => [editProduct];
}

class UpdateEditProductError extends UpdateState {
  final String message;
  final int statusCode;

  const UpdateEditProductError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class UpdateProductError extends UpdateState {
  final String message;
  final int statusCode;

  const UpdateProductError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class UpdateEditProductUpdated extends UpdateState {
  final String message;

  const UpdateEditProductUpdated(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateFormValidate extends UpdateState {
  final Errors errors;

  const UpdateFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}
// class UpdateEditProductLoading extends UpdateState{
//
// }

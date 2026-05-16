part of 'upload_product_bloc.dart';

abstract class UploadProductState extends Equatable {
  const UploadProductState();

  @override
  List<Object> get props => [];
}

class UploadProductInitial extends UploadProductState {
  const UploadProductInitial();
}

class UploadProductLoading extends UploadProductState {}

class UploadProductTypeInfoLoaded extends UploadProductState {
  final ProductTypeModel productType;

  const UploadProductTypeInfoLoaded(this.productType);

  @override
  List<Object> get props => [productType];
}

class UploadProductTypeInfoError extends UploadProductState {
  final String message;
  final int statusCode;

  const UploadProductTypeInfoError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class UploadProductUploaded extends UploadProductState {
  final String message;

  const UploadProductUploaded(this.message);

  @override
  List<Object> get props => [message];
}

class UploadProductUpdated extends UploadProductState {
  final String message;

  const UploadProductUpdated(this.message);

  @override
  List<Object> get props => [message];
}

class UploadProductFormError extends UploadProductState {
  final Errors errors;

  const UploadProductFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

class UploadProductError extends UploadProductState {
  final String message;
  final int statusCode;

  const UploadProductError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

part of 'variant_cubit.dart';

abstract class VariantState extends Equatable {
  const VariantState();

  @override
  List<Object> get props => [];
}

class VariantInitial extends VariantState {
  const VariantInitial();
}

class VariantUploading extends VariantState {
  const VariantUploading();
}

class VariantUploaded extends VariantState {
  final String upload;

  const VariantUploaded(this.upload);

  @override
  List<Object> get props => [upload];
}

class VariantFormError extends VariantState {
  final Errors errors;

  const VariantFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

class VariantError extends VariantState {
  final String message;
  final int statusCode;

  const VariantError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class VariantDeleting extends VariantState {
  const VariantDeleting();
}

class VariantDeleteError extends VariantState {
  final String message;
  final int statusCode;

  const VariantDeleteError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class VariantDeleted extends VariantState {
  final String delete;

  const VariantDeleted(this.delete);

  @override
  List<Object> get props => [delete];
}

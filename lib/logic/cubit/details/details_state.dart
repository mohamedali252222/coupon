part of 'details_cubit.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {
  const DetailsInitial();

  @override
  List<Object> get props => [];
}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final ProductDetailsModel details;

  const DetailsLoaded(this.details);

  @override
  List<Object> get props => [details];
}

class DetailsError extends DetailsState {
  final String message;
  final int statusCode;

  const DetailsError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class PostCommentError extends DetailsState {
  final String message;
  final int statusCode;

  const PostCommentError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class DetailsFormError extends DetailsState {
  final Errors errors;

  const DetailsFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

class DetailsSendMessageLoading extends DetailsState {}

class PostCommentLoading extends DetailsState {}

class PostReviewLoading extends DetailsState {}

class DetailsSendMessageLoaded extends DetailsState {
  final String message;

  const DetailsSendMessageLoaded(this.message);

  @override
  List<Object> get props => [message];
}

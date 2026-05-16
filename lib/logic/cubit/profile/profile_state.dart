part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object> get props => [];
}

class ProfileStateLoading extends ProfileState {
  const ProfileStateLoading();

  @override
  List<Object> get props => [];
}

class ProfileStateUpdating extends ProfileState {
  const ProfileStateUpdating();

  @override
  List<Object> get props => [];
}

class ProfileStateLoaded extends ProfileState {
  final UserModel userModel;

  const ProfileStateLoaded(this.userModel);

  @override
  List<Object> get props => [userModel];
}

class ProfileStateError extends ProfileState {
  final String message;
  final int statusCode;

  const ProfileStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class ProfileStateUpdateError extends ProfileState {
  final String message;
  final int statusCode;

  const ProfileStateUpdateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class ProfileStateFormValidate extends ProfileState {
  final Errors errors;

  const ProfileStateFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}

class ProfileStateUpdated extends ProfileState {
  final String message;

  const ProfileStateUpdated(this.message);

  @override
  List<Object> get props => [message];
}

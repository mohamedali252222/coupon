part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpEventName extends SignUpEvent {
  final String name;

  const SignUpEventName(this.name);

  @override
  List<Object> get props => [name];
}

class SignUpEventEmail extends SignUpEvent {
  final String email;

  const SignUpEventEmail(this.email);

  @override
  List<Object> get props => [email];
}

class SignUpEventLanguageCode extends SignUpEvent {
  final String languageCode;

  const SignUpEventLanguageCode(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}

class SignUpEventPassword extends SignUpEvent {
  final String password;

  const SignUpEventPassword(this.password);

  @override
  List<Object> get props => [password];
}

class SignUpEventPasswordConfirm extends SignUpEvent {
  final String passwordConfirm;

  const SignUpEventPasswordConfirm(this.passwordConfirm);

  @override
  List<Object> get props => [passwordConfirm];
}

class SignUpEventShowPassword extends SignUpEvent {
  final bool isShow;

  const SignUpEventShowPassword(this.isShow);

  @override
  List<Object> get props => [isShow];
}

class SignUpEventShowConfirmPassword extends SignUpEvent {
  final bool isShow;

  const SignUpEventShowConfirmPassword(this.isShow);

  @override
  List<Object> get props => [isShow];
}

class SignUpEventSubmit extends SignUpEvent {
  const SignUpEventSubmit();
}

class SignUpEventVerificationCode extends SignUpEvent {
  final String code;

  const SignUpEventVerificationCode(this.code);

  @override
  List<Object> get props => [code];
}
class SignUpEventNewUserVerification extends SignUpEvent {
  final String token;

  const SignUpEventNewUserVerification(this.token);

  @override
  List<Object> get props => [token];
}

class SignUpEventNewUserSubmit extends SignUpEvent {}

class SignUpEventFormDataClear extends SignUpEvent {
  const SignUpEventFormDataClear();
}

class SignUpEventResendVerificationSubmit extends SignUpEvent {
  const SignUpEventResendVerificationSubmit();

  @override
  List<Object> get props => [];
}

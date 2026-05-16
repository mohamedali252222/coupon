part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginEventUserEmail extends LoginEvent {
  final String email;

  const LoginEventUserEmail(this.email);

  @override
  List<Object> get props => [email];
}

class LoginEventPassword extends LoginEvent {
  final String password;

  const LoginEventPassword(this.password);

  @override
  List<Object> get props => [password];
}

class LoginEventLanguageCode extends LoginEvent {
  final String languageCode;


  const LoginEventLanguageCode(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}

class LangCodeClear extends LoginEvent {}

class LoginEventCurrencyIcon extends LoginEvent {
  final String currencyIcon;

  const LoginEventCurrencyIcon(this.currencyIcon);

  @override
  List<Object> get props => [currencyIcon];
}

class SaveUserCredentialEvent extends LoginEvent {
  final bool isActive;

  const SaveUserCredentialEvent(this.isActive);

  @override
  List<Object> get props => [isActive];
}

class LoginEventShowPassword extends LoginEvent {
  final bool showPassword;

  const LoginEventShowPassword(this.showPassword);

  @override
  List<Object> get props => [showPassword];
}

class LoginEventRememberMe extends LoginEvent {
  final bool isRemember;

  const LoginEventRememberMe(this.isRemember);

  @override
  List<Object> get props => [isRemember];
}

class LoginEventSubmit extends LoginEvent {
  const LoginEventSubmit();
}

class LoginEventLogout extends LoginEvent {
  const LoginEventLogout();
}

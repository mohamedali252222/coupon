import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'login_bloc.dart';

class LoginStateModel extends Equatable {
  final String email;
  final String password;
  final String languageCode;
  final String currencyIcon;
  final bool isActive;
  final bool showPassword;
  final bool isRemember;
  final LoginState loginState;

  const LoginStateModel({
    this.email = 'user@gmail.com',
    this.password = '1234',
    this.languageCode = '',
    this.currencyIcon = '',
    this.isActive = false,
    this.showPassword = true,
    this.isRemember = true,
    this.loginState = const LoginStateInitial(),
  });

  LoginStateModel copyWith({
    String? email,
    String? password,
    String? languageCode,
    String? currencyIcon,
    bool? isActive,
    bool? showPassword,
    bool? isRemember,
    LoginState? loginState,
  }) {
    return LoginStateModel(
      email: email ?? this.email,
      password: password ?? this.password,
      languageCode: languageCode ?? this.languageCode,
      currencyIcon: currencyIcon ?? this.currencyIcon,
      isActive: isActive ?? this.isActive,
      showPassword: showPassword ?? this.showPassword,
      isRemember: isRemember ?? this.isRemember,
      loginState: loginState ?? this.loginState,
    );
  }

  LoginStateModel clear() {
    return const LoginStateModel(
      email: '',
      password: '',
      languageCode: '',
      currencyIcon: '',
      isActive: false,
      showPassword: false,
      isRemember: true,
      loginState: LoginStateInitial(),
    );
  }

  Map<String, String> toMap() {
    final result = <String, String>{};
    result.addAll({'email': email.trim()});
    result.addAll({'password': password.trim()});
    result.addAll({'lang_code': languageCode.trim()});
    return result;
  }

  factory LoginStateModel.fromMap(Map<String, dynamic> map) {
    return LoginStateModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      languageCode: map['lang_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginStateModel.fromJson(String source) =>
      LoginStateModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginModelState(email: $email, password: $password,languageCode: $languageCode state: $loginState)';

  @override
  List<Object> get props => [
        email,
        password,
        languageCode,
        isActive,
        showPassword,
        isRemember,
        loginState,
        currencyIcon,
      ];
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'forgot_password_cubit.dart';

class PasswordStateModel extends Equatable {
  final String email;
  final String code;
  final String password;
  final String languageCode;
  final String confirmPassword;
  final bool showPassword;
  final bool showConfirmPassword;
  final ForgotPasswordState passwordState;

  const PasswordStateModel({
    this.email = '',
    this.code = '',
    this.password = '',
    this.languageCode = '',
    this.confirmPassword = '',
    this.showPassword = true,
    this.showConfirmPassword = true,
    this.passwordState = const ForgotPasswordStateInitial(),
  });

  PasswordStateModel copyWith({
    String? email,
    String? code,
    String? password,
    String? languageCode,
    String? confirmPassword,
    bool? showPassword,
    bool? showConfirmPassword,
    ForgotPasswordState? passwordState,
  }) {
    return PasswordStateModel(
      email: email ?? this.email,
      code: code ?? this.code,
      password: password ?? this.password,
      languageCode: languageCode ?? this.languageCode,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      passwordState: passwordState ?? this.passwordState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'token': code,
      'password': password,
      'c_password': confirmPassword,
      'lang_code': languageCode,
      // 'showPassword': showPassword,
      // 'showConfirmPassword': showConfirmPassword,
    };
  }

  static PasswordStateModel init() {
    return const PasswordStateModel(
      email: '',
      code: '',
      password: '',
      languageCode: '',
      confirmPassword: '',
      showPassword: true,
      showConfirmPassword: true,
      passwordState: ForgotPasswordStateInitial(),
    );
  }

  PasswordStateModel clear() {
    return const PasswordStateModel(
      email: '',
      code: '',
      password: '',
      confirmPassword: '',
      showPassword: true,
      showConfirmPassword: true,
      passwordState: ForgotPasswordStateInitial(),
    );
  }

  factory PasswordStateModel.fromMap(Map<String, dynamic> map) {
    return PasswordStateModel(
      email: map['email'] ?? '',
      code: map['token'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['password_confirmation'] ?? '',
      showPassword: map['showPassword'] ?? false,
      showConfirmPassword: map['showConfirmPassword'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordStateModel.fromJson(String source) =>
      PasswordStateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PasswordStateModel(email: $email, code: $code, password: $password, confirmPassword: $confirmPassword, showPassword: $showPassword, showConfirmPassword: $showConfirmPassword, passwordState: $passwordState)';
  }

  @override
  List<Object> get props {
    return [
      email,
      code,
      password,
      languageCode,
      confirmPassword,
      showPassword,
      showConfirmPassword,
      passwordState,
    ];
  }
}

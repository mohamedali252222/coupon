import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'sign_up_bloc.dart';

class SignUpStateModel extends Equatable {
  final int agree;
  final String name;
  final String email;
  final String languageCode;
  final String token;
  final String countryCode;
  final String password;
  final bool showPassword;
  final bool showConfirmPassword;
  final String confirmPassword;
  final SignUpState signUpState;

  const SignUpStateModel({
    this.agree = 0,
    this.name = '',
    this.email = '',
    this.languageCode = '',
    this.token = '',
    this.countryCode = '',
    this.password = '',
    this.confirmPassword = '',
    this.showPassword = true,
    this.showConfirmPassword = true,
    this.signUpState = const SignUpStateInitial(),
  });

  SignUpStateModel copyWith({
    int? agree,
    String? name,
    String? email,
    String? languageCode,
    String? token,
    String? countryCode,
    String? password,
    String? confirmPassword,
    bool? showPassword,
    bool? showConfirmPassword,
    SignUpState? signUpState,
  }) {
    return SignUpStateModel(
      agree: agree ?? this.agree,
      name: name ?? this.name,
      email: email ?? this.email,
      languageCode: languageCode ?? this.languageCode,
      token: token ?? this.token,
      countryCode: countryCode ?? this.countryCode,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      signUpState: signUpState ?? this.signUpState,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'agree': agree.toString()});
    result.addAll({'name': name.trim()});
    result.addAll({'email': email.trim()});
    result.addAll({'token': token});
    result.addAll({'password': password});
    result.addAll({'c_password': confirmPassword});
    result.addAll({'lang_code': languageCode});
    return result;
  }

  SignUpStateModel clear() {
    return const SignUpStateModel(
      agree: 0,
      name: '',
      email: '',
      token: '',
      countryCode: '',
      password: '',
      confirmPassword: '',
      showPassword: true,
      showConfirmPassword: true,
      signUpState: SignUpStateInitial(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'SignUpModelState(agree: $agree, name: $name, email: $email, token: $token, countryCode: $countryCode, password: $password, confirmPassword: $confirmPassword, signUpState: $signUpState)';
  }

  @override
  List<Object> get props {
    return [
      agree,
      name,
      email,
      languageCode,
      token,
      countryCode,
      password,
      showPassword,
      showConfirmPassword,
      confirmPassword,
      signUpState,
    ];
  }
}

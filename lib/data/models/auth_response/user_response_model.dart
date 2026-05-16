import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_model.dart';

class UserResponseModel extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final UserModel? user;

  const UserResponseModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  UserResponseModel copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
    UserModel? user,
  }) {
    return UserResponseModel(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user!.toMap(),
    };
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      accessToken: map['access_token'] ?? '',
      tokenType: map['token_type'] ?? '',
      expiresIn: map['expires_in'] ?? 0,
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) =>
      UserResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserResponseModel(accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, user: $user)';
  }

  @override
  List<Object> get props => [accessToken, tokenType, expiresIn, user!];
}

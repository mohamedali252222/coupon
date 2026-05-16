// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthorModel extends Equatable {
  final int id;
  final String name;
  final String userName;
  final String email;
  final String phone;
  final String image;
  final String provider;
  final String providerAvatar;
  final String createdAt;
  final String updatedAt;

  const AuthorModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.phone,
    required this.image,
    required this.provider,
    required this.providerAvatar,
    required this.createdAt,
    required this.updatedAt,
  });

  AuthorModel copyWith({
    int? id,
    String? name,
    String? userName,
    String? email,
    String? phone,
    String? image,
    String? provider,
    String? providerAvatar,
    String? createdAt,
    String? updatedAt,
  }) {
    return AuthorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      provider: provider ?? this.provider,
      providerAvatar: providerAvatar ?? this.providerAvatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'user_name': userName,
      'email': email,
      'phone': phone,
      'image': image,
      'provider': provider,
      'provider_avatar': providerAvatar,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory AuthorModel.fromMap(Map<String, dynamic> map) {
    return AuthorModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      userName: map['user_name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      provider: map['provider'] ?? '',
      providerAvatar: map['provider_avatar'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorModel.fromJson(String source) =>
      AuthorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      userName,
      email,
      phone,
      image,
      provider,
      providerAvatar,
      createdAt,
      updatedAt,
    ];
  }
}

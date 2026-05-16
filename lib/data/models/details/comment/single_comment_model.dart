import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_comment_model.dart';

class SingleCommentModel extends Equatable {
  final int id;
  final int productId;
  final int userId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String comment;
  final int status;
  final String createdAt;
  final String updatedAt;
  final UserCommentModel? user;

  const SingleCommentModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.comment,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  SingleCommentModel copyWith({
    int? id,
    int? productId,
    int? userId,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? comment,
    int? status,
    String? createdAt,
    String? updatedAt,
    UserCommentModel? user,
  }) {
    return SingleCommentModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      comment: comment ?? this.comment,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'comment': comment,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user!.toMap(),
    };
  }

  factory SingleCommentModel.fromMap(Map<String, dynamic> map) {
    return SingleCommentModel(
      id: map['id'] as int,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      comment: map['comment'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      user: map['user'] != null
          ? UserCommentModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleCommentModel.fromJson(String source) =>
      SingleCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      userId,
      name,
      email,
      phone,
      address,
      comment,
      status,
      createdAt,
      updatedAt,
      user!,
    ];
  }
}

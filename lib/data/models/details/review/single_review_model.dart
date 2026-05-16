import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../comment/user_comment_model.dart';

class SingleReviewModel extends Equatable {
  final int id;
  final int productId;
  final int orderId;
  final int variantId;
  final int userId;
  final int authorId;
  final String review;
  final int rating;
  final int status;
  final String createdAt;
  final String updatedAt;
  final UserCommentModel? user;

  const SingleReviewModel({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.variantId,
    required this.userId,
    required this.authorId,
    required this.review,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  SingleReviewModel copyWith({
    int? id,
    int? productId,
    int? orderId,
    int? variantId,
    int? userId,
    int? authorId,
    String? review,
    int? rating,
    int? status,
    String? createdAt,
    String? updatedAt,
    UserCommentModel? user,
  }) {
    return SingleReviewModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      orderId: orderId ?? this.orderId,
      variantId: variantId ?? this.variantId,
      userId: userId ?? this.userId,
      authorId: authorId ?? this.authorId,
      review: review ?? this.review,
      rating: rating ?? this.rating,
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
      'order_id': orderId,
      'variant_id': variantId,
      'user_id': userId,
      'author_id': authorId,
      'review': review,
      'rating': rating,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user!.toMap(),
    };
  }

  factory SingleReviewModel.fromMap(Map<String, dynamic> map) {
    return SingleReviewModel(
      id: map['id'] as int,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      orderId:
          map['order_id'] != null ? int.parse(map['order_id'].toString()) : 0,
      variantId: map['variant_id'] != null
          ? int.parse(map['variant_id'].toString())
          : 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      authorId:
          map['author_id'] != null ? int.parse(map['author_id'].toString()) : 0,
      review: map['review'] ?? '',
      rating: map['rating'] != null ? int.parse(map['rating'].toString()) : 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      user: map['user'] != null
          ? UserCommentModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleReviewModel.fromJson(String source) =>
      SingleReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      orderId,
      variantId,
      userId,
      authorId,
      review,
      rating,
      status,
      createdAt,
      updatedAt,
      user!,
    ];
  }
}

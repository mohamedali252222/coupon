import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductLangFrontEndModel extends Equatable {
  final int id;
  final int productId;
  final String langCode;
  final String name;
  final String description;
  final String tags;
  final String seoTitle;
  final String seoDescription;
  final String createdAt;
  final String updatedAt;

  const ProductLangFrontEndModel({
    required this.id,
    required this.productId,
    required this.langCode,
    required this.name,
    required this.description,
    required this.tags,
    required this.seoTitle,
    required this.seoDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  ProductLangFrontEndModel copyWith({
    int? id,
    int? productId,
    String? langCode,
    String? name,
    String? description,
    String? tags,
    String? seoTitle,
    String? seoDescription,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProductLangFrontEndModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      langCode: langCode ?? this.langCode,
      name: name ?? this.name,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'lang_code': langCode,
      'name': name,
      'description': description,
      'tags': tags,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ProductLangFrontEndModel.fromMap(Map<String, dynamic> map) {
    return ProductLangFrontEndModel(
      id: map['id'] ?? 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      langCode: map['lang_code'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      tags: map['tags'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductLangFrontEndModel.fromJson(String source) =>
      ProductLangFrontEndModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      langCode,
      name,
      description,
      tags,
      seoTitle,
      seoDescription,
      createdAt,
      updatedAt,
    ];
  }
}

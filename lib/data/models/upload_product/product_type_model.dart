import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductTypeModel extends Equatable {
  final int id;
  final String image;
  final String createdAt;
  final String updatedAt;
  final PageLangFrontEnd? pagelangfrontend;

  const ProductTypeModel({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.pagelangfrontend,
  });

  ProductTypeModel copyWith({
    int? id,
    String? image,
    String? createdAt,
    String? updatedAt,
    PageLangFrontEnd? pagelangfrontend,
  }) {
    return ProductTypeModel(
      id: id ?? this.id,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pagelangfrontend: pagelangfrontend ?? this.pagelangfrontend,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pagelangfrontend': pagelangfrontend!.toMap(),
    };
  }

  factory ProductTypeModel.fromMap(Map<String, dynamic> map) {
    return ProductTypeModel(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      pagelangfrontend: map['pagelangfrontend'] != null
          ? PageLangFrontEnd.fromMap(
              map['pagelangfrontend'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductTypeModel.fromJson(String source) =>
      ProductTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      image,
      createdAt,
      updatedAt,
      pagelangfrontend!,
    ];
  }
}

class PageLangFrontEnd extends Equatable {
  final int id;
  final int productTypeId;
  final String langCode;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;

  const PageLangFrontEnd({
    required this.id,
    required this.productTypeId,
    required this.langCode,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  PageLangFrontEnd copyWith({
    int? id,
    int? productTypeId,
    String? langCode,
    String? title,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return PageLangFrontEnd(
      id: id ?? this.id,
      productTypeId: productTypeId ?? this.productTypeId,
      langCode: langCode ?? this.langCode,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_type_id': productTypeId,
      'lang_code': langCode,
      'title': title,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory PageLangFrontEnd.fromMap(Map<String, dynamic> map) {
    return PageLangFrontEnd(
      id: map['id'] ?? 0,
      productTypeId: map['product_type_id'] != null
          ? int.parse(map['product_type_id'].toString())
          : 0,
      langCode: map['lang_code'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PageLangFrontEnd.fromJson(String source) =>
      PageLangFrontEnd.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productTypeId,
      langCode,
      title,
      description,
      createdAt,
      updatedAt,
    ];
  }
}

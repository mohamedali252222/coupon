import 'dart:convert';

import 'package:equatable/equatable.dart';

class SingleTemplateModel extends Equatable {
  final int id;
  final String image;
  final String link;
  final String slug;
  final String icon;
  final int productGallery;
  final int status;
  final String createdAt;
  final String updatedAt;
  final CatLangFrontEndModel? catLangFrontEndModel;

  const SingleTemplateModel({
    required this.id,
    required this.image,
    required this.link,
    required this.slug,
    required this.icon,
    required this.productGallery,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.catLangFrontEndModel,
  });

  SingleTemplateModel copyWith({
    int? id,
    String? image,
    String? link,
    String? slug,
    String? icon,
    int? productGallery,
    int? status,
    String? createdAt,
    String? updatedAt,
    CatLangFrontEndModel? catLangFrontEndModel,
  }) {
    return SingleTemplateModel(
      id: id ?? this.id,
      image: slug ?? this.slug,
      link: link ?? this.link,
      slug: slug ?? this.slug,
      icon: icon ?? this.icon,
      productGallery: productGallery ?? this.productGallery,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      catLangFrontEndModel: catLangFrontEndModel ?? this.catLangFrontEndModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': slug,
      'link': link,
      'slug': slug,
      'icon': icon,
      'product_gallery': productGallery,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'templatelangfrontend': catLangFrontEndModel!.toMap(),
    };
  }

  factory SingleTemplateModel.fromMap(Map<String, dynamic> map) {
    return SingleTemplateModel(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      link: map['link'] ?? '',
      slug: map['slug'] ?? '',
      icon: map['icon'] ?? '',
      productGallery: map['product_gallery'] != null
          ? int.parse(map['product_gallery'].toString())
          : 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      catLangFrontEndModel: map['templatelangfrontend'] != null
          ? CatLangFrontEndModel.fromMap(
              map['templatelangfrontend'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleTemplateModel.fromJson(String source) =>
      SingleTemplateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      image,
      link,
      slug,
      icon,
      productGallery,
      status,
      createdAt,
      updatedAt,
      catLangFrontEndModel!,
    ];
  }
}

class CatLangFrontEndModel extends Equatable {
  final int id;
  final int categoryId;
  final String langCode;
  final String name;
  final String createdAt;
  final String updatedAt;

  const CatLangFrontEndModel({
    required this.id,
    required this.categoryId,
    required this.langCode,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  CatLangFrontEndModel copyWith({
    int? id,
    int? categoryId,
    String? langCode,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) {
    return CatLangFrontEndModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      langCode: langCode ?? this.langCode,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category_id': categoryId,
      'lang_code': langCode,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory CatLangFrontEndModel.fromMap(Map<String, dynamic> map) {
    return CatLangFrontEndModel(
      id: map['id'] as int,
      categoryId: map['category_id'] != null
          ? int.parse(map['category_id'].toString())
          : 0,
      langCode: map['lang_code'] ?? '',
      name: map['name'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CatLangFrontEndModel.fromJson(String source) =>
      CatLangFrontEndModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      categoryId,
      langCode,
      name,
      createdAt,
      updatedAt,
    ];
  }
}

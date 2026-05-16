import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../details/product_item_model.dart';
import '../details/variant/variant_model.dart';
import '../home/category/home_single_category_model.dart';
import '../setting/language_model.dart';

class EditProductModel extends Equatable {
  final ProductItemModel product;
  final List<VariantModel>? variants;
  final ProductLanguage? productLanguage;
  final String productType;
  final List<SingleCategoryModel>? categories;
  final List<LanguageModel>? languages;

  const EditProductModel({
    required this.product,
    required this.variants,
    required this.productLanguage,
    required this.productType,
    required this.categories,
    required this.languages,
  });

  EditProductModel copyWith({
    ProductItemModel? product,
    List<VariantModel>? variants,
    ProductLanguage? productLanguage,
    String? productType,
    List<SingleCategoryModel>? categories,
    List<LanguageModel>? languages,
  }) {
    return EditProductModel(
      product: product ?? this.product,
      variants: variants ?? this.variants,
      productLanguage: productLanguage ?? this.productLanguage,
      productType: productType ?? this.productType,
      categories: categories ?? this.categories,
      languages: languages ?? this.languages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'product_variants': variants!.map((x) => x.toMap()).toList(),
      'product_language': productLanguage!.toMap(),
      'product_type': productType,
      'categories': categories!.map((x) => x.toMap()).toList(),
      'languages': languages!.map((x) => x.toMap()).toList(),
    };
  }

  factory EditProductModel.fromMap(Map<String, dynamic> map) {
    return EditProductModel(
      product: ProductItemModel.fromMap(map['product'] as Map<String, dynamic>),
      categories: map['categories'] != null
          ? List<SingleCategoryModel>.from(
              (map['categories'] as List<dynamic>).map<SingleCategoryModel?>(
                (x) => SingleCategoryModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      productLanguage: map['product_language'] != null
          ? ProductLanguage.fromMap(
              map['product_language'] as Map<String, dynamic>)
          : null,
      productType: map['product_type'] ?? '',
      variants: map['product_variants'] != null
          ? List<VariantModel>.from(
              (map['product_variants'] as List<dynamic>).map<VariantModel>(
                (x) => VariantModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      languages: map['languages'] != null
          ? List<LanguageModel>.from(
              (map['languages'] as List<dynamic>).map<LanguageModel?>(
                (x) => LanguageModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProductModel.fromJson(String source) =>
      EditProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      product,
      productLanguage!,
      productType,
      categories!,
      variants!,
      languages!,
    ];
  }
}

class ProductLanguage extends Equatable {
  final int id;
  final String productId;
  final String langCode;
  final String name;
  final String description;
  final String tags;
  final String seoTitle;
  final String seoDescription;
  final String createdAt;
  final String updatedAt;

  const ProductLanguage({
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

  ProductLanguage copyWith({
    int? id,
    String? productId,
    String? langCode,
    String? name,
    String? description,
    String? tags,
    String? seoTitle,
    String? seoDescription,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProductLanguage(
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

  factory ProductLanguage.fromMap(Map<String, dynamic> map) {
    return ProductLanguage(
      id: map['id'] ?? 0,
      productId: map['product_id'] ?? '',
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

  factory ProductLanguage.fromJson(String source) =>
      ProductLanguage.fromMap(json.decode(source) as Map<String, dynamic>);

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

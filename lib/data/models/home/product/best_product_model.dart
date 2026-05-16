import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../category/home_single_category_model.dart';
import 'author_model.dart';
import 'product_language_front_end_model.dart';

class BestProductModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String productType;
  final String thumbnailImage;
  final double regularPrice;
  final String previewLink;
  final int categoryId;
  final int authorId;
  final int status;
  final int approveByAdmin;
  final int soldItemsCount;
  final SingleCategoryModel? category;
  final AuthorModel? author;
  final ProductLangFrontEndModel? productLangFrontEnd;

  const BestProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.productType,
    required this.thumbnailImage,
    required this.regularPrice,
    required this.previewLink,
    required this.categoryId,
    required this.authorId,
    required this.status,
    required this.approveByAdmin,
    required this.soldItemsCount,
    required this.category,
    required this.author,
    required this.productLangFrontEnd,
  });

  BestProductModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? productType,
    String? thumbnailImage,
    double? regularPrice,
    String? previewLink,
    int? categoryId,
    int? authorId,
    int? status,
    int? approveByAdmin,
    int? soldItemsCount,
    SingleCategoryModel? category,
    AuthorModel? author,
    ProductLangFrontEndModel? productLangFrontEnd,
  }) {
    return BestProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      productType: productType ?? this.productType,
      thumbnailImage: thumbnailImage ?? this.thumbnailImage,
      regularPrice: regularPrice ?? this.regularPrice,
      previewLink: previewLink ?? this.previewLink,
      categoryId: categoryId ?? this.categoryId,
      authorId: authorId ?? this.authorId,
      status: status ?? this.status,
      approveByAdmin: approveByAdmin ?? this.approveByAdmin,
      soldItemsCount: soldItemsCount ?? this.soldItemsCount,
      category: category ?? this.category,
      author: author ?? this.author,
      productLangFrontEnd: productLangFrontEnd ?? this.productLangFrontEnd,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'product_type': productType,
      'thumbnail_image': thumbnailImage,
      'regular_price': regularPrice,
      'preview_link': previewLink,
      'category_id': categoryId,
      'author_id': authorId,
      'status': status,
      'approve_by_admin': approveByAdmin,
      'sold_items_count': soldItemsCount,
      'category': category!.toMap(),
      'author': author!.toMap(),
      'productlangfrontend': productLangFrontEnd!.toMap(),
    };
  }

  factory BestProductModel.fromMap(Map<String, dynamic> map) {
    return BestProductModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      productType: map['product_type'] ?? '',
      thumbnailImage: map['thumbnail_image'] ?? '',
      regularPrice: map['regular_price'] != null
          ? double.parse(map['regular_price'].toString())
          : 0,
      previewLink: map['preview_link'] ?? '',
      categoryId: map['category_id'] != null
          ? int.parse(map['category_id'].toString())
          : 0,
      authorId:
          map['author_id'] != null ? int.parse(map['author_id'].toString()) : 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      approveByAdmin: map['approve_by_admin'] != null
          ? int.parse(map['approve_by_admin'].toString())
          : 0,
      soldItemsCount: map['sold_items_count'] != null
          ? int.parse(map['sold_items_count'].toString())
          : 0,
      category: map['category'] != null
          ? SingleCategoryModel.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      author: map['author'] != null
          ? AuthorModel.fromMap(map['author'] as Map<String, dynamic>)
          : null,
      productLangFrontEnd: map['productlangfrontend'] != null
          ? ProductLangFrontEndModel.fromMap(
              map['productlangfrontend'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BestProductModel.fromJson(String source) =>
      BestProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      productType,
      thumbnailImage,
      regularPrice,
      previewLink,
      categoryId,
      authorId,
      status,
      approveByAdmin,
      soldItemsCount,
      category!,
      author!,
      productLangFrontEnd!,
    ];
  }
}

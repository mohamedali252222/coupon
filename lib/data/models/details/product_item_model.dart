import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../home/category/home_single_category_model.dart';
import '../home/product/author_model.dart';
import '../home/product/product_language_front_end_model.dart';

class ProductItemModel extends Equatable {
  final int id;
  final int authorId;
  final int categoryId;
  final String productType;
  final String name;
  final String slug;
  final double regularPrice;
  final double extendPrice;
  final String previewLink;
  final String thumbnailImage;
  final String downloadFile;
  final String productIcon;
  final String downloadFileType;
  final String downloadLink;
  final String description;
  final String releaseDate;
  final String lastUpdateDate;
  final String usedTechnology;
  final String fileType;
  final int highResolution;
  final int crossBrowser;
  final int documentation;
  final int layout;
  final String fileSize;
  final String tags;
  final String seoTitle;
  final String seoDescription;
  final int status;
  final int approveByAdmin;
  final int popularItem;
  final int trendingItem;
  final String createdAt;
  final String updatedAt;
  final int totalSold;
  final double averageRating;
  final int totalRating;
  final int totalComment;
  final ProductLangFrontEndModel? productLangFrontEnd;
  final SingleCategoryModel? category;
  final AuthorModel? author;

  const ProductItemModel({
    required this.id,
    required this.authorId,
    required this.categoryId,
    required this.productType,
    required this.name,
    required this.slug,
    required this.regularPrice,
    required this.extendPrice,
    required this.previewLink,
    required this.thumbnailImage,
    required this.downloadFile,
    required this.productIcon,
    required this.downloadFileType,
    required this.downloadLink,
    required this.description,
    required this.releaseDate,
    required this.lastUpdateDate,
    required this.usedTechnology,
    required this.fileType,
    required this.highResolution,
    required this.crossBrowser,
    required this.documentation,
    required this.layout,
    required this.fileSize,
    required this.tags,
    required this.seoTitle,
    required this.seoDescription,
    required this.status,
    required this.approveByAdmin,
    required this.popularItem,
    required this.trendingItem,
    required this.createdAt,
    required this.updatedAt,
    required this.totalSold,
    required this.averageRating,
    required this.totalRating,
    required this.totalComment,
    required this.productLangFrontEnd,
    required this.category,
    required this.author,
  });

  ProductItemModel copyWith({
    int? id,
    int? authorId,
    int? categoryId,
    String? productType,
    String? name,
    String? slug,
    double? regularPrice,
    double? extendPrice,
    String? previewLink,
    String? thumbnailImage,
    String? downloadFile,
    String? productIcon,
    String? downloadFileType,
    String? downloadLink,
    String? description,
    String? releaseDate,
    String? lastUpdateDate,
    String? usedTechnology,
    String? fileType,
    int? highResolution,
    int? crossBrowser,
    int? documentation,
    int? layout,
    String? fileSize,
    String? tags,
    String? seoTitle,
    String? seoDescription,
    int? status,
    int? approveByAdmin,
    int? popularItem,
    int? trendingItem,
    String? createdAt,
    String? updatedAt,
    int? totalSold,
    double? averageRating,
    int? totalRating,
    int? totalComment,
    ProductLangFrontEndModel? productLangFrontEnd,
    SingleCategoryModel? category,
    AuthorModel? author,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      categoryId: categoryId ?? this.categoryId,
      productType: productType ?? this.productType,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      regularPrice: regularPrice ?? this.regularPrice,
      extendPrice: extendPrice ?? this.extendPrice,
      previewLink: previewLink ?? this.previewLink,
      thumbnailImage: thumbnailImage ?? this.thumbnailImage,
      downloadFile: downloadFile ?? this.downloadFile,
      productIcon: productIcon ?? this.productIcon,
      downloadFileType: downloadFileType ?? this.downloadFileType,
      downloadLink: downloadLink ?? this.downloadLink,
      description: description ?? this.description,
      releaseDate: releaseDate ?? this.releaseDate,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      usedTechnology: usedTechnology ?? this.usedTechnology,
      fileType: fileType ?? this.fileType,
      highResolution: highResolution ?? this.highResolution,
      crossBrowser: crossBrowser ?? this.crossBrowser,
      documentation: documentation ?? this.documentation,
      layout: layout ?? this.layout,
      fileSize: fileSize ?? this.fileSize,
      tags: tags ?? this.tags,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      status: status ?? this.status,
      approveByAdmin: approveByAdmin ?? this.approveByAdmin,
      popularItem: popularItem ?? this.popularItem,
      trendingItem: trendingItem ?? this.trendingItem,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalSold: totalSold ?? this.totalSold,
      averageRating: averageRating ?? this.averageRating,
      totalRating: totalRating ?? this.totalRating,
      totalComment: totalComment ?? this.totalComment,
      productLangFrontEnd: productLangFrontEnd ?? this.productLangFrontEnd,
      category: category ?? this.category,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author_id': authorId,
      'category_id': categoryId,
      'product_type': productType,
      'name': name,
      'slug': slug,
      'regular_price': regularPrice,
      'extend_price': extendPrice,
      'preview_link': previewLink,
      'thumbnail_image': thumbnailImage,
      'download_file': downloadFile,
      'product_icon': productIcon,
      'download_file_type': downloadFileType,
      'download_link': downloadLink,
      'description': description,
      'release_date': releaseDate,
      'last_update_date': lastUpdateDate,
      'used_technology': usedTechnology,
      'file_type': fileType,
      'high_resolution': highResolution,
      'cross_browser': crossBrowser,
      'documentation': documentation,
      'layout': layout,
      'file_size': fileSize,
      'tags': tags,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'status': status,
      'approve_by_admin': approveByAdmin,
      'popular_item': popularItem,
      'trending_item': trendingItem,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'totalSold': totalSold,
      'averageRating': averageRating,
      'totalRating': totalRating,
      'totalComment': totalComment,
      'category': category!.toMap(),
      'productlangfrontend': productLangFrontEnd!.toMap(),
      'author': author!.toMap(),
    };
  }

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    return ProductItemModel(
      id: map['id'] ?? 0,
      authorId:
          map['author_id'] != null ? int.parse(map['author_id'].toString()) : 0,
      categoryId: map['category_id'] != null
          ? int.parse(map['category_id'].toString())
          : 0,
      productType: map['product_type'] ?? '',
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      regularPrice: map['regular_price'] != null
          ? double.parse(map['regular_price'].toString())
          : 0,
      extendPrice: map['extend_price'] != null
          ? double.parse(map['extend_price'].toString())
          : 0,
      previewLink: map['preview_link'] ?? '',
      thumbnailImage: map['thumbnail_image'] ?? '',
      downloadFile: map['download_file'] ?? '',
      productIcon: map['product_icon'] ?? '',
      downloadFileType: map['download_file_type'] ?? '',
      downloadLink: map['download_link'] ?? '',
      description: map['description'] ?? '',
      releaseDate: map['release_date'] ?? '',
      lastUpdateDate: map['last_update_date'] ?? '',
      usedTechnology: map['used_technology'] ?? '',
      fileType: map['file_type'] ?? '',
      highResolution: map['high_resolution'] != null
          ? int.parse(map['high_resolution'].toString())
          : 0,
      crossBrowser: map['cross_browser'] != null
          ? int.parse(map['cross_browser'].toString())
          : 0,
      documentation: map['documentation'] != null
          ? int.parse(map['documentation'].toString())
          : 0,
      layout: map['layout'] != null ? int.parse(map['layout'].toString()) : 0,
      fileSize: map['file_size'] ?? '',
      tags: map['tags'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      approveByAdmin: map['approve_by_admin'] != null
          ? int.parse(map['approve_by_admin'].toString())
          : 0,
      popularItem: map['popular_item'] != null
          ? int.parse(map['popular_item'].toString())
          : 0,
      trendingItem: map['trending_item'] != null
          ? int.parse(map['trending_item'].toString())
          : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      totalSold:
          map['totalSold'] != null ? int.parse(map['totalSold'].toString()) : 0,
      averageRating: map['averageRating'] != null
          ? double.parse(map['averageRating'].toString())
          : 0.0,
      totalRating: map['totalRating'] != null
          ? int.parse(map['totalRating'].toString())
          : 0,
      totalComment: map['totalComment'] != null
          ? int.parse(map['totalComment'].toString())
          : 0,
      productLangFrontEnd: map['productlangfrontend'] != null
          ? ProductLangFrontEndModel.fromMap(
              map['productlangfrontend'] as Map<String, dynamic>)
          : null,
      category: map['category'] != null
          ? SingleCategoryModel.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      author: map['author'] != null
          ? AuthorModel.fromMap(map['author'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductItemModel.fromJson(String source) =>
      ProductItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      authorId,
      categoryId,
      productType,
      name,
      slug,
      regularPrice,
      extendPrice,
      previewLink,
      thumbnailImage,
      downloadFile,
      productIcon,
      downloadFileType,
      downloadLink,
      description,
      releaseDate,
      lastUpdateDate,
      usedTechnology,
      fileType,
      highResolution,
      crossBrowser,
      documentation,
      layout,
      fileSize,
      tags,
      seoTitle,
      seoDescription,
      status,
      approveByAdmin,
      popularItem,
      trendingItem,
      createdAt,
      updatedAt,
      totalSold,
      averageRating,
      totalRating,
      totalComment,
      productLangFrontEnd!,
      //category!,
      //author!,
    ];
  }
}

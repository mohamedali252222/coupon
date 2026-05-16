// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../home/product/product_language_front_end_model.dart';

class WishlistModel extends Equatable {
  final int id;
  final int userId;
  final int authorId;
  final int productId;
  final String createdAt;
  final String updatedAt;
  final WishlistItem? product;

  const WishlistModel({
    required this.id,
    required this.userId,
    required this.authorId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  WishlistModel copyWith({
    int? id,
    int? userId,
    int? authorId,
    int? productId,
    String? createdAt,
    String? updatedAt,
    WishlistItem? product,
  }) {
    return WishlistModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      authorId: authorId ?? this.authorId,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'author_id': authorId,
      'product_id': productId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'product': product!.toMap(),
    };
  }

  factory WishlistModel.fromMap(Map<String, dynamic> map) {
    return WishlistModel(
      id: map['id'] != null ? int.parse(map['id'].toString()) : 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      authorId:
          map['author_id'] != null ? int.parse(map['author_id'].toString()) : 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      product: map['product'] != null
          ? WishlistItem.fromMap(map['product'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistModel.fromJson(String source) =>
      WishlistModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      authorId,
      productId,
      createdAt,
      updatedAt,
      product!,
    ];
  }
}

class WishlistItem extends Equatable {
  final int id;
  final int authorId;
  final int categoryId;
  final String productType;
  final String name;
  final String slug;
  final double regularPrice;
  final String extendPrice;
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
  final int featuredItem;
  final String createdAt;
  final String updatedAt;
  final ProductLangFrontEndModel? productlangfrontend;

  const WishlistItem({
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
    required this.featuredItem,
    required this.createdAt,
    required this.updatedAt,
    this.productlangfrontend,
  });

  WishlistItem copyWith({
    int? id,
    int? authorId,
    int? categoryId,
    String? productType,
    String? name,
    String? slug,
    double? regularPrice,
    String? extendPrice,
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
    int? featuredItem,
    String? createdAt,
    String? updatedAt,
    ProductLangFrontEndModel? productlangfrontend,
  }) {
    return WishlistItem(
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
      featuredItem: featuredItem ?? this.featuredItem,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      productlangfrontend: productlangfrontend ?? this.productlangfrontend,
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
      'featured_item': featuredItem,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'productlangfrontend': productlangfrontend!.toMap(),
    };
  }

  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
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
          : 0.0,
      extendPrice: map['extend_price'] ?? '',
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
      featuredItem: map['featured_item'] != null
          ? int.parse(map['featured_item'].toString())
          : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      productlangfrontend: map['productlangfrontend'] != null
          ? ProductLangFrontEndModel.fromMap(
              map['productlangfrontend'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistItem.fromJson(String source) =>
      WishlistItem.fromMap(json.decode(source) as Map<String, dynamic>);

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
      featuredItem,
      createdAt,
      updatedAt,
      productlangfrontend!,
    ];
  }
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'upload_product_bloc.dart';

class UploadProductStateModel extends Equatable {
  final String thumbImage;
  final String productIcon;
  final String uploadFile;
  final String name;
  final String slug;
  final String category;
  final String previewLink;
  final String productType;
  final String regularPrice;
  final String extendPrice;
  final String description;
  final String tags;
  final String seoTitle;
  final String seoDescription;
  final String highResolution;
  final String crossBrowser;
  final String documentation;
  final String layout;
  final String languageCode;
  final UploadProductState uploadProductState;

  const UploadProductStateModel({
    this.thumbImage = '',
    this.productIcon = '',
    this.uploadFile = '',
    this.name = '',
    this.slug = '',
    this.category = '',
    this.previewLink = '',
    this.productType = '',
    this.regularPrice = '',
    this.extendPrice = '',
    this.description = '',
    this.tags = '',
    this.seoTitle = '',
    this.seoDescription = '',
    this.highResolution = '0',
    this.crossBrowser = '0',
    this.documentation = '0',
    this.layout = '0',
    this.languageCode = '',
    this.uploadProductState = const UploadProductInitial(),
  });

  UploadProductStateModel copyWith({
    String? thumbImage,
    String? productIcon,
    String? uploadFile,
    String? name,
    String? slug,
    String? category,
    String? previewLink,
    String? productType,
    String? regularPrice,
    String? extendPrice,
    String? description,
    String? tags,
    String? seoTitle,
    String? seoDescription,
    String? highResolution,
    String? crossBrowser,
    String? documentation,
    String? layout,
    String? languageCode,
    UploadProductState? uploadProductState,
  }) {
    return UploadProductStateModel(
      thumbImage: thumbImage ?? this.thumbImage,
      productIcon: productIcon ?? this.productIcon,
      uploadFile: uploadFile ?? this.uploadFile,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      category: category ?? this.category,
      previewLink: previewLink ?? this.previewLink,
      productType: productType ?? this.productType,
      regularPrice: regularPrice ?? this.regularPrice,
      extendPrice: extendPrice ?? this.extendPrice,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      highResolution: highResolution ?? this.highResolution,
      crossBrowser: crossBrowser ?? this.crossBrowser,
      documentation: documentation ?? this.documentation,
      layout: layout ?? this.layout,
      languageCode: languageCode ?? this.languageCode,
      uploadProductState: uploadProductState ?? this.uploadProductState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      //'thumb_image': thumbImage,
      //'product_icon': productIcon,
      //'upload_file': uploadFile,
      'name': name,
      'slug': slug,
      'category': category,
      'preview_link': previewLink,
      'product_type': productType,
      'regular_price': regularPrice,
      'extend_price': extendPrice,
      'description': description,
      'tags': tags,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'high_resolution': highResolution,
      'cross_browser': crossBrowser,
      'documentation': documentation,
      'layout': layout,
      'lang_code': languageCode,
    };
  }

  static UploadProductStateModel init() {
    return const UploadProductStateModel(
      thumbImage: '',
      productIcon: '',
      uploadFile: '',
      name: '',
      slug: '',
      category: '',
      previewLink: '',
      productType: '',
      regularPrice: '',
      extendPrice: '',
      description: '',
      tags: '',
      seoTitle: '',
      seoDescription: '',
      highResolution: '0',
      crossBrowser: '0',
      documentation: '0',
      layout: '0',
      languageCode: '',
      uploadProductState: UploadProductInitial(),
    );
  }

  UploadProductStateModel clear() {
    return const UploadProductStateModel(
      thumbImage: '',
      productIcon: '',
      uploadFile: '',
      name: '',
      slug: '',
      category: '',
      previewLink: '',
      productType: '',
      regularPrice: '',
      extendPrice: '',
      description: '',
      tags: '',
      seoTitle: '',
      seoDescription: '',
      highResolution: '0',
      crossBrowser: '0',
      documentation: '0',
      layout: '0',
      languageCode: '',
      uploadProductState: UploadProductInitial(),
    );
  }

  factory UploadProductStateModel.fromMap(Map<String, dynamic> map) {
    return UploadProductStateModel(
      thumbImage: map['thumb_image'] ?? '',
      productIcon: map['product_icon'] ?? '',
      uploadFile: map['upload_file'] ?? '',
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      category: map['category'] ?? '',
      previewLink: map['preview_link'] ?? '',
      productType: map['product_type'] ?? '',
      regularPrice: map['regular_price'] ?? '',
      extendPrice: map['extend_price'] ?? '',
      description: map['description'] ?? '',
      tags: map['tags'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      highResolution: map['high_resolution'] ?? '',
      crossBrowser: map['cross_browser'] ?? '',
      documentation: map['documentation'] ?? '',
      layout: map['layout'] ?? '',
      languageCode: map['lang_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadProductStateModel.fromJson(String source) =>
      UploadProductStateModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      thumbImage,
      productIcon,
      uploadFile,
      name,
      slug,
      category,
      previewLink,
      productType,
      regularPrice,
      extendPrice,
      description,
      tags,
      seoTitle,
      seoDescription,
      highResolution,
      crossBrowser,
      documentation,
      layout,
      languageCode,
      uploadProductState,
    ];
  }
}

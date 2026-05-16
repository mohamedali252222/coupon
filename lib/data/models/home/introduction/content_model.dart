import 'dart:convert';

import 'package:equatable/equatable.dart';

class ContentModel extends Equatable {
  final int id;
  final int totalProduct;
  final int totalSold;
  final int totalUser;
  final String home2Image;
  final String home1Bg;
  final String home2Bg;
  final String home3Image;
  final String home3Bg;
  final String createdAt;
  final String updatedAt;
  final SliderLangFontEnd? sliderLangFontEnd;

  const ContentModel({
    required this.id,
    required this.totalProduct,
    required this.totalSold,
    required this.totalUser,
    required this.home2Image,
    required this.home1Bg,
    required this.home2Bg,
    required this.home3Image,
    required this.home3Bg,
    required this.createdAt,
    required this.updatedAt,
    required this.sliderLangFontEnd,
  });

  ContentModel copyWith({
    int? id,
    int? totalProduct,
    int? totalSold,
    int? totalUser,
    String? home2Image,
    String? home1Bg,
    String? home2Bg,
    String? home3Image,
    String? home3Bg,
    String? createdAt,
    String? updatedAt,
    SliderLangFontEnd? sliderLangFontEnd,
  }) {
    return ContentModel(
      id: id ?? this.id,
      totalProduct: totalProduct ?? this.totalProduct,
      totalSold: totalSold ?? this.totalSold,
      totalUser: totalUser ?? this.totalUser,
      home2Image: home2Image ?? this.home2Image,
      home1Bg: home1Bg ?? this.home1Bg,
      home2Bg: home2Bg ?? this.home2Bg,
      home3Image: home3Image ?? this.home3Image,
      home3Bg: home3Bg ?? this.home3Bg,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sliderLangFontEnd: sliderLangFontEnd ?? this.sliderLangFontEnd,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'total_product': totalProduct,
      'total_sold': totalSold,
      'total_user': totalUser,
      'home2_image': home2Image,
      'home1_bg': home1Bg,
      'home2_bg': home2Bg,
      'home3_image': home3Image,
      'home3_bg': home3Bg,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'sliderlangfrontend': sliderLangFontEnd!.toMap(),
    };
  }

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      id: map['id'] ?? 0,
      totalProduct: map['total_product'] != null
          ? int.parse(map['total_product'].toString())
          : 0,
      totalSold: map['total_sold'] != null
          ? int.parse(map['total_sold'].toString())
          : 0,
      totalUser: map['total_user'] != null
          ? int.parse(map['total_user'].toString())
          : 0,
      home2Image: map['home2_image'] ?? '',
      home1Bg: map['home1_bg'] ?? '',
      home2Bg: map['home2_bg'] ?? '',
      home3Image: map['home3_image'] ?? '',
      home3Bg: map['home3_bg'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      sliderLangFontEnd: map['sliderlangfrontend'] != null
          ? SliderLangFontEnd.fromMap(
              map['sliderlangfrontend'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContentModel.fromJson(String source) =>
      ContentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      totalProduct,
      totalSold,
      totalUser,
      home2Image,
      home1Bg,
      home2Bg,
      home3Image,
      home3Bg,
      createdAt,
      updatedAt,
      sliderLangFontEnd!,
    ];
  }
}

class SliderLangFontEnd extends Equatable {
  final int id;
  final int sliderId;
  final String langCode;
  final String home1Title;
  final String home2Title;
  final String home2Description;
  final String home3Title;
  final String home3Description;
  final String createdAt;
  final String updatedAt;

  const SliderLangFontEnd({
    required this.id,
    required this.sliderId,
    required this.langCode,
    required this.home1Title,
    required this.home2Title,
    required this.home2Description,
    required this.home3Title,
    required this.home3Description,
    required this.createdAt,
    required this.updatedAt,
  });

  SliderLangFontEnd copyWith({
    int? id,
    int? sliderId,
    String? langCode,
    String? home1Title,
    String? home2Title,
    String? home2Description,
    String? home3Title,
    String? home3Description,
    String? createdAt,
    String? updatedAt,
  }) {
    return SliderLangFontEnd(
      id: id ?? this.id,
      sliderId: sliderId ?? this.sliderId,
      langCode: langCode ?? this.langCode,
      home1Title: home1Title ?? this.home1Title,
      home2Title: home2Title ?? this.home2Title,
      home2Description: home2Description ?? this.home2Description,
      home3Title: home3Title ?? this.home3Title,
      home3Description: home3Description ?? this.home3Description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'slider_id': sliderId,
      'lang_code': langCode,
      'home1_title': home1Title,
      'home2_title': home2Title,
      'home2_description': home2Description,
      'home3_title': home3Title,
      'home3_description': home3Description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SliderLangFontEnd.fromMap(Map<String, dynamic> map) {
    return SliderLangFontEnd(
      id: map['id'] ?? 0,
      sliderId:
          map['slider_id'] != null ? int.parse(map['slider_id'].toString()) : 0,
      langCode: map['lang_code'] ?? '',
      home1Title: map['home1_title'] ?? '',
      home2Title: map['home2_title'] ?? '',
      home2Description: map['home2_description'] ?? '',
      home3Title: map['home3_title'] ?? '',
      home3Description: map['home3_description'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderLangFontEnd.fromJson(String source) =>
      SliderLangFontEnd.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      sliderId,
      langCode,
      home1Title,
      home2Title,
      home2Description,
      home3Title,
      home3Description,
      createdAt,
      updatedAt,
    ];
  }
}

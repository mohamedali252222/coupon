import 'dart:convert';

import 'package:equatable/equatable.dart';

class AboutUs extends Equatable {
  final int id;
  final String bannerImage;
  final String image;
  final String signature;
  final String createdAt;
  final String updatedAt;
  final AboutLangFrontEnd? aboutlangfrontend;

  const AboutUs({
    required this.id,
    required this.bannerImage,
    required this.image,
    required this.signature,
    required this.createdAt,
    required this.updatedAt,
    this.aboutlangfrontend,
  });

  AboutUs copyWith({
    int? id,
    String? bannerImage,
    String? image,
    String? signature,
    String? createdAt,
    String? updatedAt,
    AboutLangFrontEnd? aboutlangfrontend,
  }) {
    return AboutUs(
      id: id ?? this.id,
      bannerImage: bannerImage ?? this.bannerImage,
      image: image ?? this.image,
      signature: signature ?? this.signature,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      aboutlangfrontend: aboutlangfrontend ?? this.aboutlangfrontend,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'banner_image': bannerImage,
      'image': image,
      'signature': signature,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'aboutlangfrontend': aboutlangfrontend?.toMap(),
    };
  }

  factory AboutUs.fromMap(Map<String, dynamic> map) {
    return AboutUs(
      id: map['id'] ?? 0,
      bannerImage: map['banner_image'] ?? '',
      image: map['image'] ?? '',
      signature: map['signature'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      aboutlangfrontend: map['aboutlangfrontend'] != null
          ? AboutLangFrontEnd.fromMap(
              map['aboutlangfrontend'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutUs.fromJson(String source) =>
      AboutUs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      bannerImage,
      image,
      signature,
      createdAt,
      updatedAt,
      aboutlangfrontend!,
    ];
  }
}

class AboutLangFrontEnd extends Equatable {
  final int id;
  final int aboutId;
  final String langCode;
  final String title;
  final String header1;
  final String header2;
  final String header3;
  final String aboutUs;
  final String name;
  final String desgination;
  final String createdAt;
  final String updatedAt;

  const AboutLangFrontEnd({
    required this.id,
    required this.aboutId,
    required this.langCode,
    required this.title,
    required this.header1,
    required this.header2,
    required this.header3,
    required this.aboutUs,
    required this.name,
    required this.desgination,
    required this.createdAt,
    required this.updatedAt,
  });

  AboutLangFrontEnd copyWith({
    int? id,
    int? aboutId,
    String? langCode,
    String? title,
    String? header1,
    String? header2,
    String? header3,
    String? aboutUs,
    String? name,
    String? desgination,
    String? createdAt,
    String? updatedAt,
  }) {
    return AboutLangFrontEnd(
      id: id ?? this.id,
      aboutId: aboutId ?? this.aboutId,
      langCode: langCode ?? this.langCode,
      title: title ?? this.title,
      header1: header1 ?? this.header1,
      header2: header2 ?? this.header2,
      header3: header3 ?? this.header3,
      aboutUs: aboutUs ?? this.aboutUs,
      name: name ?? this.name,
      desgination: desgination ?? this.desgination,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'about_id': aboutId,
      'lang_code': langCode,
      'title': title,
      'header1': header1,
      'header2': header2,
      'header3': header3,
      'about_us': aboutUs,
      'name': name,
      'desgination': desgination,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory AboutLangFrontEnd.fromMap(Map<String, dynamic> map) {
    return AboutLangFrontEnd(
      id: map['id'] ?? '',
      aboutId:
          map['about_id'] != null ? int.parse(map['about_id'].toString()) : 0,
      langCode: map['lang_code'] ?? '',
      title: map['title'] ?? '',
      header1: map['header1'] ?? '',
      header2: map['header2'] ?? '',
      header3: map['header3'] ?? '',
      aboutUs: map['about_us'] ?? '',
      name: map['name'] ?? '',
      desgination: map['desgination'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutLangFrontEnd.fromJson(String source) =>
      AboutLangFrontEnd.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      aboutId,
      langCode,
      title,
      header1,
      header2,
      header3,
      aboutUs,
      name,
      desgination,
      createdAt,
      updatedAt,
    ];
  }
}

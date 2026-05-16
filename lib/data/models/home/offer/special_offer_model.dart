import 'dart:convert';

import 'package:equatable/equatable.dart';

class SpecialOfferModel extends Equatable {
  final bool visibility;
  final String title1;
  final String title2;
  final String link;
  final String home1Background;
  final String home1Foreground1;
  final String home1Foreground2;
  final String home2Background;
  final String home3Background;
  final String home3Item1Image;
  final String home3Item2Image;
  final String home3Item1Title;
  final String home3Item2Title;
  final String home3Item1Description;
  final String home3Item2Description;
  final String home3Item1Link;
  final String home3Item2Link;

  const SpecialOfferModel({
    required this.visibility,
    required this.title1,
    required this.title2,
    required this.link,
    required this.home1Background,
    required this.home1Foreground1,
    required this.home1Foreground2,
    required this.home2Background,
    required this.home3Background,
    required this.home3Item1Image,
    required this.home3Item2Image,
    required this.home3Item1Title,
    required this.home3Item2Title,
    required this.home3Item1Description,
    required this.home3Item2Description,
    required this.home3Item1Link,
    required this.home3Item2Link,
  });

  SpecialOfferModel copyWith({
    bool? visibility,
    String? title1,
    String? title2,
    String? link,
    String? home1Background,
    String? home1Foreground1,
    String? home1Foreground2,
    String? home2Background,
    String? home3Background,
    String? home3Item1Image,
    String? home3Item2Image,
    String? home3Item1Title,
    String? home3Item2Title,
    String? home3Item1Description,
    String? home3Item2Description,
    String? home3Item1Link,
    String? home3Item2Link,
  }) {
    return SpecialOfferModel(
      visibility: visibility ?? this.visibility,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      link: link ?? this.link,
      home1Background: home1Background ?? this.home1Background,
      home1Foreground1: home1Foreground1 ?? this.home1Foreground1,
      home1Foreground2: home1Foreground2 ?? this.home1Foreground2,
      home2Background: home2Background ?? this.home2Background,
      home3Background: home3Background ?? this.home3Background,
      home3Item1Image: home3Item1Image ?? this.home3Item1Image,
      home3Item2Image: home3Item2Image ?? this.home3Item2Image,
      home3Item1Title: home3Item1Title ?? this.home3Item1Title,
      home3Item2Title: home3Item2Title ?? this.home3Item2Title,
      home3Item1Description:
          home3Item1Description ?? this.home3Item1Description,
      home3Item2Description:
          home3Item2Description ?? this.home3Item2Description,
      home3Item1Link: home3Item1Link ?? this.home3Item1Link,
      home3Item2Link: home3Item2Link ?? this.home3Item2Link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'title1': title1,
      'title2': title2,
      'link': link,
      'home1_background': home1Background,
      'home1_foreground1': home1Foreground1,
      'home1_foreground2': home1Foreground2,
      'home2_background': home2Background,
      'home3_background': home3Background,
      'home3_item1_image': home3Item1Image,
      'home3_item2_image': home3Item2Image,
      'home3_item1_title': home3Item1Title,
      'home3_item2_title': home3Item2Title,
      'home3_item1_description': home3Item1Description,
      'home3_item2_description': home3Item2Description,
      'home3_item1_link': home3Item1Link,
      'home3_item2_link': home3Item2Link,
    };
  }

  factory SpecialOfferModel.fromMap(Map<String, dynamic> map) {
    return SpecialOfferModel(
      visibility: map['visibility'] ?? true,
      title1: map['title1'] ?? '',
      title2: map['title2'] ?? '',
      link: map['link'] ?? '',
      home1Background: map['home1_background'] ?? '',
      home1Foreground1: map['home1_foreground1'] ?? '',
      home1Foreground2: map['home1_foreground2'] ?? '',
      home2Background: map['home2_background'] ?? '',
      home3Background: map['home3_background'] ?? '',
      home3Item1Image: map['home3_item1_image'] ?? '',
      home3Item2Image: map['home3_item2_image'] ?? '',
      home3Item1Title: map['home3_item1_title'] ?? '',
      home3Item2Title: map['home3_item2_title'] ?? '',
      home3Item1Description: map['home3_item1_description'] ?? '',
      home3Item2Description: map['home3_item2_description'] ?? '',
      home3Item1Link: map['home3_item1_link'] ?? '',
      home3Item2Link: map['home3_item2_link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecialOfferModel.fromJson(String source) =>
      SpecialOfferModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      visibility,
      title1,
      title2,
      link,
      home1Background,
      home1Foreground1,
      home1Foreground2,
      home2Background,
      home3Background,
      home3Item1Image,
      home3Item2Image,
      home3Item1Title,
      home3Item2Title,
      home3Item1Description,
      home3Item2Description,
      home3Item1Link,
      home3Item2Link,
    ];
  }
}

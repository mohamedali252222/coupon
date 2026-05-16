// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChooseModel extends Equatable {
  final bool visibility;
  final String title1;
  final String title2;
  final String icon1;
  final String itemTitle1;
  final String icon2;
  final String itemTitle2;
  final String icon3;
  final String itemTitle3;
  final String backgroundImage;
  final String home3Icon1;
  final String home3Icon2;
  final String home3Icon3;
  final String home3Title1;
  final String home3Title2;
  final String home3Title3;
  final String home3Description1;
  final String home3Description2;
  final String home3Description3;

  const ChooseModel({
    required this.visibility,
    required this.title1,
    required this.title2,
    required this.icon1,
    required this.itemTitle1,
    required this.icon2,
    required this.itemTitle2,
    required this.icon3,
    required this.itemTitle3,
    required this.backgroundImage,
    required this.home3Icon1,
    required this.home3Icon2,
    required this.home3Icon3,
    required this.home3Title1,
    required this.home3Title2,
    required this.home3Title3,
    required this.home3Description1,
    required this.home3Description2,
    required this.home3Description3,
  });

  ChooseModel copyWith({
    bool? visibility,
    String? title1,
    String? title2,
    String? icon1,
    String? itemTitle1,
    String? icon2,
    String? itemTitle2,
    String? icon3,
    String? itemTitle3,
    String? backgroundImage,
    String? home3Icon1,
    String? home3Icon2,
    String? home3Icon3,
    String? home3Title1,
    String? home3Title2,
    String? home3Title3,
    String? home3Description1,
    String? home3Description2,
    String? home3Description3,
  }) {
    return ChooseModel(
      visibility: visibility ?? this.visibility,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      icon1: icon1 ?? this.icon1,
      itemTitle1: itemTitle1 ?? this.itemTitle1,
      icon2: icon2 ?? this.icon2,
      itemTitle2: itemTitle2 ?? this.itemTitle2,
      icon3: icon3 ?? this.icon3,
      itemTitle3: itemTitle3 ?? this.itemTitle3,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      home3Icon1: home3Icon1 ?? this.home3Icon1,
      home3Icon2: home3Icon2 ?? this.home3Icon2,
      home3Icon3: home3Icon3 ?? this.home3Icon3,
      home3Title1: home3Title1 ?? this.home3Title1,
      home3Title2: home3Title2 ?? this.home3Title2,
      home3Title3: home3Title3 ?? this.home3Title3,
      home3Description1: home3Description1 ?? this.home3Description1,
      home3Description2: home3Description2 ?? this.home3Description2,
      home3Description3: home3Description3 ?? this.home3Description3,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'title1': title1,
      'title2': title2,
      'icon1': icon1,
      'item_title1': itemTitle1,
      'icon2': icon2,
      'item_title2': itemTitle2,
      'icon3': icon3,
      'item_title3': itemTitle3,
      'background_image': backgroundImage,
      'home3_icon1': home3Icon1,
      'home3_icon2': home3Icon2,
      'home3_icon3': home3Icon3,
      'home3_title1': home3Title1,
      'home3_title2': home3Title2,
      'home3_title3': home3Title3,
      'home3_description1': home3Description1,
      'home3_description2': home3Description2,
      'home3_description3': home3Description3,
    };
  }

  factory ChooseModel.fromMap(Map<String, dynamic> map) {
    return ChooseModel(
      visibility: map['visibility'] ?? true,
      title1: map['title1'] ?? '',
      title2: map['title2'] ?? '',
      icon1: map['icon1'] ?? '',
      itemTitle1: map['item_title1'] ?? '',
      icon2: map['icon2'] ?? '',
      itemTitle2: map['item_title2'] ?? '',
      icon3: map['icon3'] ?? '',
      itemTitle3: map['item_title3'] ?? '',
      backgroundImage: map['background_image'] ?? '',
      home3Icon1: map['home3_icon1'] ?? '',
      home3Icon2: map['home3_icon2'] ?? '',
      home3Icon3: map['home3_icon3'] ?? '',
      home3Title1: map['home3_title1'] ?? '',
      home3Title2: map['home3_title2'] ?? '',
      home3Title3: map['home3_title3'] ?? '',
      home3Description1: map['home3_description1'] ?? '',
      home3Description2: map['home3_description2'] ?? '',
      home3Description3: map['home3_description3'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChooseModel.fromJson(String source) =>
      ChooseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      visibility,
      title1,
      title2,
      icon1,
      itemTitle1,
      icon2,
      itemTitle2,
      icon3,
      itemTitle3,
      backgroundImage,
      home3Icon1,
      home3Icon2,
      home3Icon3,
      home3Title1,
      home3Title2,
      home3Title3,
      home3Description1,
      home3Description2,
      home3Description3,
    ];
  }
}

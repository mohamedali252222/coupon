import 'dart:convert';

import 'package:equatable/equatable.dart';

class CounterSection extends Equatable {
  final bool visibitliy;
  final String home1Icon1;
  final String home1Icon2;
  final String home1Icon3;
  final String home1Icon4;
  final String counter1Title;
  final String counter2Title;
  final String counter3Title;
  final String counter4Title;
  final int counter1Value;
  final int counter2Value;
  final int counter3Value;
  final int counter4Value;

  const CounterSection({
    required this.visibitliy,
    required this.home1Icon1,
    required this.home1Icon2,
    required this.home1Icon3,
    required this.home1Icon4,
    required this.counter1Title,
    required this.counter2Title,
    required this.counter3Title,
    required this.counter4Title,
    required this.counter1Value,
    required this.counter2Value,
    required this.counter3Value,
    required this.counter4Value,
  });

  CounterSection copyWith({
    bool? visibitliy,
    String? home1Icon1,
    String? home1Icon2,
    String? home1Icon3,
    String? home1Icon4,
    String? counter1Title,
    String? counter2Title,
    String? counter3Title,
    String? counter4Title,
    int? counter1Value,
    int? counter2Value,
    int? counter3Value,
    int? counter4Value,
  }) {
    return CounterSection(
      visibitliy: visibitliy ?? this.visibitliy,
      home1Icon1: home1Icon1 ?? this.home1Icon1,
      home1Icon2: home1Icon2 ?? this.home1Icon2,
      home1Icon3: home1Icon3 ?? this.home1Icon3,
      home1Icon4: home1Icon4 ?? this.home1Icon4,
      counter1Title: counter1Title ?? this.counter1Title,
      counter2Title: counter2Title ?? this.counter2Title,
      counter3Title: counter3Title ?? this.counter3Title,
      counter4Title: counter4Title ?? this.counter4Title,
      counter1Value: counter1Value ?? this.counter1Value,
      counter2Value: counter2Value ?? this.counter2Value,
      counter3Value: counter3Value ?? this.counter3Value,
      counter4Value: counter4Value ?? this.counter4Value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibitliy': visibitliy,
      'home1_icon1': home1Icon1,
      'home1_icon2': home1Icon2,
      'home1_icon3': home1Icon3,
      'home1_icon4': home1Icon4,
      'counter1_title': counter1Title,
      'counter2_title': counter2Title,
      'counter3_title': counter3Title,
      'counter4_title': counter4Title,
      'counter1_value': counter1Value,
      'counter2_value': counter2Value,
      'counter3_value': counter3Value,
      'counter4_value': counter4Value,
    };
  }

  factory CounterSection.fromMap(Map<String, dynamic> map) {
    return CounterSection(
      visibitliy: map['visibitliy'] ?? true,
      home1Icon1: map['home1_icon1'] ?? '',
      home1Icon2: map['home1_icon2'] ?? '',
      home1Icon3: map['home1_icon3'] ?? '',
      home1Icon4: map['home1_icon4'] ?? '',
      counter1Title: map['counter1_title'] ?? '',
      counter2Title: map['counter2_title'] ?? '',
      counter3Title: map['counter3_title'] ?? '',
      counter4Title: map['counter4_title'] ?? '',
      counter1Value: map['counter1_value'] != null
          ? int.parse(map['counter1_value'].toString())
          : 0,
      counter2Value: map['counter2_value'] != null
          ? int.parse(map['counter2_value'].toString())
          : 0,
      counter3Value: map['counter3_value'] != null
          ? int.parse(map['counter3_value'].toString())
          : 0,
      counter4Value: map['counter4_value'] != null
          ? int.parse(map['counter4_value'].toString())
          : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterSection.fromJson(String source) =>
      CounterSection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      visibitliy,
      home1Icon1,
      home1Icon2,
      home1Icon3,
      home1Icon4,
      counter1Title,
      counter2Title,
      counter3Title,
      counter4Title,
      counter1Value,
      counter2Value,
      counter3Value,
      counter4Value,
    ];
  }
}

class WhyChooseUs extends Equatable {
  final bool visibility;
  final String title1;
  final String title2;
  final String itemIcon1;
  final String itemIcon2;
  final String itemIcon3;
  final String itemTitle1;
  final String itemTitle2;
  final String itemTitle3;
  final String itemDescription1;
  final String itemDescription2;
  final String itemDescription3;

  const WhyChooseUs({
    required this.visibility,
    required this.title1,
    required this.title2,
    required this.itemIcon1,
    required this.itemIcon2,
    required this.itemIcon3,
    required this.itemTitle1,
    required this.itemTitle2,
    required this.itemTitle3,
    required this.itemDescription1,
    required this.itemDescription2,
    required this.itemDescription3,
  });

  WhyChooseUs copyWith({
    bool? visibility,
    String? title1,
    String? title2,
    String? itemIcon1,
    String? itemIcon2,
    String? itemIcon3,
    String? itemTitle1,
    String? itemTitle2,
    String? itemTitle3,
    String? itemDescription1,
    String? itemDescription2,
    String? itemDescription3,
  }) {
    return WhyChooseUs(
      visibility: visibility ?? this.visibility,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      itemIcon1: itemIcon1 ?? this.itemIcon1,
      itemIcon2: itemIcon2 ?? this.itemIcon2,
      itemIcon3: itemIcon3 ?? this.itemIcon3,
      itemTitle1: itemTitle1 ?? this.itemTitle1,
      itemTitle2: itemTitle2 ?? this.itemTitle2,
      itemTitle3: itemTitle3 ?? this.itemTitle3,
      itemDescription1: itemDescription1 ?? this.itemDescription1,
      itemDescription2: itemDescription2 ?? this.itemDescription2,
      itemDescription3: itemDescription3 ?? this.itemDescription3,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'title1': title1,
      'title2': title2,
      'item_icon1': itemIcon1,
      'item_icon2': itemIcon2,
      'item_icon3': itemIcon3,
      'item_title1': itemTitle1,
      'item_title2': itemTitle2,
      'item_title3': itemTitle3,
      'item_description1': itemDescription1,
      'item_description2': itemDescription2,
      'item_description3': itemDescription3,
    };
  }

  factory WhyChooseUs.fromMap(Map<String, dynamic> map) {
    return WhyChooseUs(
      visibility: map['visibility'] ?? true,
      title1: map['title1'] ?? '',
      title2: map['title2'] ?? '',
      itemIcon1: map['item_icon1'] ?? '',
      itemIcon2: map['item_icon2'] ?? '',
      itemIcon3: map['item_icon3'] ?? '',
      itemTitle1: map['item_title1'] ?? '',
      itemTitle2: map['item_title2'] ?? '',
      itemTitle3: map['item_title3'] ?? '',
      itemDescription1: map['item_description1'] ?? '',
      itemDescription2: map['item_description2'] ?? '',
      itemDescription3: map['item_description3'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WhyChooseUs.fromJson(String source) =>
      WhyChooseUs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      visibility,
      title1,
      title2,
      itemIcon1,
      itemIcon2,
      itemIcon3,
      itemTitle1,
      itemTitle2,
      itemTitle3,
      itemDescription1,
      itemDescription2,
      itemDescription3,
    ];
  }
}

class Partners extends Equatable {
  final int id;
  final String link;
  final String logo;
  final int status;
  final String createdAt;
  final String updatedAt;

  const Partners({
    required this.id,
    required this.link,
    required this.logo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Partners copyWith({
    int? id,
    String? link,
    String? logo,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return Partners(
      id: id ?? this.id,
      link: link ?? this.link,
      logo: logo ?? this.logo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'link': link,
      'logo': logo,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Partners.fromMap(Map<String, dynamic> map) {
    return Partners(
      id: map['id'] ?? 0,
      link: map['link'] ?? '',
      logo: map['logo'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Partners.fromJson(String source) =>
      Partners.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      link,
      logo,
      status,
      createdAt,
      updatedAt,
    ];
  }
}

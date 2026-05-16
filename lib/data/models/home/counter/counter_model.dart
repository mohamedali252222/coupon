import 'dart:convert';

import 'package:equatable/equatable.dart';

class CounterModel extends Equatable {
  final bool visibitliy;
  final String home1Icon1;
  final String home1Icon2;
  final String home1Icon3;
  final String home1Icon4;
  final String home2Icon1;
  final String home2Icon2;
  final String home2Icon3;
  final String home2Icon4;
  final String counter1Title;
  final String counter2Title;
  final String counter3Title;
  final String counter4Title;
  final int counter1Value;
  final int counter2Value;
  final int counter3Value;
  final int counter4Value;
  final String counterHome2Background;

  const CounterModel({
    required this.visibitliy,
    required this.home1Icon1,
    required this.home1Icon2,
    required this.home1Icon3,
    required this.home1Icon4,
    required this.home2Icon1,
    required this.home2Icon2,
    required this.home2Icon3,
    required this.home2Icon4,
    required this.counter1Title,
    required this.counter2Title,
    required this.counter3Title,
    required this.counter4Title,
    required this.counter1Value,
    required this.counter2Value,
    required this.counter3Value,
    required this.counter4Value,
    required this.counterHome2Background,
  });

  CounterModel copyWith({
    bool? visibitliy,
    String? home1Icon1,
    String? home1Icon2,
    String? home1Icon3,
    String? home1Icon4,
    String? home2Icon1,
    String? home2Icon2,
    String? home2Icon3,
    String? home2Icon4,
    String? counter1Title,
    String? counter2Title,
    String? counter3Title,
    String? counter4Title,
    int? counter1Value,
    int? counter2Value,
    int? counter3Value,
    int? counter4Value,
    String? counterHome2Background,
  }) {
    return CounterModel(
      visibitliy: visibitliy ?? this.visibitliy,
      home1Icon1: home1Icon1 ?? this.home1Icon1,
      home1Icon2: home1Icon2 ?? this.home1Icon2,
      home1Icon3: home1Icon3 ?? this.home1Icon3,
      home1Icon4: home1Icon4 ?? this.home1Icon4,
      home2Icon1: home2Icon1 ?? this.home2Icon1,
      home2Icon2: home2Icon2 ?? this.home2Icon2,
      home2Icon3: home2Icon3 ?? this.home2Icon3,
      home2Icon4: home2Icon4 ?? this.home2Icon4,
      counter1Title: counter1Title ?? this.counter1Title,
      counter2Title: counter2Title ?? this.counter2Title,
      counter3Title: counter3Title ?? this.counter3Title,
      counter4Title: counter4Title ?? this.counter4Title,
      counter1Value: counter1Value ?? this.counter1Value,
      counter2Value: counter2Value ?? this.counter2Value,
      counter3Value: counter3Value ?? this.counter3Value,
      counter4Value: counter4Value ?? this.counter4Value,
      counterHome2Background:
          counterHome2Background ?? this.counterHome2Background,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibitliy': visibitliy,
      'home1_icon1': home1Icon1,
      'home1_icon2': home1Icon2,
      'home1_icon3': home1Icon3,
      'home1_icon4': home1Icon4,
      'home2_icon1': home2Icon1,
      'home2_icon2': home2Icon2,
      'home2_icon3': home2Icon3,
      'home2_icon4': home2Icon4,
      'counter1_title': counter1Title,
      'counter2_title': counter2Title,
      'counter3_title': counter3Title,
      'counter4_title': counter4Title,
      'counter1_value': counter1Value,
      'counter2_value': counter2Value,
      'counter3_value': counter3Value,
      'counter4_value': counter4Value,
      'counter_home2_background': counterHome2Background,
    };
  }

  factory CounterModel.fromMap(Map<String, dynamic> map) {
    return CounterModel(
      visibitliy: map['visibitliy'] ?? true,
      home1Icon1: map['home1_icon1'] ?? '',
      home1Icon2: map['home1_icon2'] ?? '',
      home1Icon3: map['home1_icon3'] ?? '',
      home1Icon4: map['home1_icon4'] ?? '',
      home2Icon1: map['home2_icon1'] ?? '',
      home2Icon2: map['home2_icon2'] ?? '',
      home2Icon3: map['home2_icon3'] ?? '',
      home2Icon4: map['home2_icon4'] ?? '',
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
      counterHome2Background: map['counter_home2_background'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterModel.fromJson(String source) =>
      CounterModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
      home2Icon1,
      home2Icon2,
      home2Icon3,
      home2Icon4,
      counter1Title,
      counter2Title,
      counter3Title,
      counter4Title,
      counter1Value,
      counter2Value,
      counter3Value,
      counter4Value,
      counterHome2Background,
    ];
  }
}

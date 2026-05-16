import 'dart:convert';

import 'package:equatable/equatable.dart';

class SettingModel extends Equatable {
  final int id;
  final String logo;
  final String favicon;
  final String textDirection;
  final String timezone;
  final String currencyName;
  final String currencyIcon;
  final String defaultAvatar;

  const SettingModel({
    required this.id,
    required this.logo,
    required this.favicon,
    required this.textDirection,
    required this.timezone,
    required this.currencyName,
    required this.currencyIcon,
    required this.defaultAvatar,
  });

  SettingModel copyWith({
    int? id,
    String? logo,
    String? favicon,
    String? textDirection,
    String? timezone,
    String? currencyName,
    String? currencyIcon,
    String? defaultAvatar,
  }) {
    return SettingModel(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      favicon: favicon ?? this.favicon,
      textDirection: textDirection ?? this.textDirection,
      timezone: timezone ?? this.timezone,
      currencyName: currencyName ?? this.currencyName,
      currencyIcon: currencyIcon ?? this.currencyIcon,
      defaultAvatar: defaultAvatar ?? this.defaultAvatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'logo': logo,
      'favicon': favicon,
      'text_direction': textDirection,
      'timezone': timezone,
      'currency_name': currencyName,
      'currency_icon': currencyIcon,
      'default_avatar': defaultAvatar,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      id: map['id'] ?? 0,
      logo: map['logo'] ?? '',
      favicon: map['favicon'] ?? '',
      textDirection: map['text_direction'] ?? '',
      timezone: map['timezone'] ?? '',
      currencyName: map['currency_name'] ?? '',
      currencyIcon: map['currency_icon'] ?? '',
      defaultAvatar: map['default_avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SettingModel(id: $id, logo: $logo, favicon: $favicon, textDirection: $textDirection, timezone: $timezone, currencyName: $currencyName, currencyIcon: $currencyIcon,defaultAvatar: $defaultAvatar)';
  }

  @override
  List<Object> get props {
    return [
      id,
      logo,
      favicon,
      textDirection,
      timezone,
      currencyName,
      currencyIcon,
      defaultAvatar,
    ];
  }
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

class LanguageModel extends Equatable {
  final int id;
  final String langCode;
  final String langName;
  final String isDefault;
  final int status;
  final String langDirection;
  final String createdAt;
  final String updatedAt;

  const LanguageModel({
    required this.id,
    required this.langCode,
    required this.langName,
    required this.isDefault,
    required this.status,
    required this.langDirection,
    required this.createdAt,
    required this.updatedAt,
  });

  LanguageModel copyWith({
    int? id,
    String? langCode,
    String? langName,
    String? isDefault,
    int? status,
    String? langDirection,
    String? createdAt,
    String? updatedAt,
  }) {
    return LanguageModel(
      id: id ?? this.id,
      langCode: langCode ?? this.langCode,
      langName: langName ?? this.langName,
      isDefault: isDefault ?? this.isDefault,
      status: status ?? this.status,
      langDirection: langDirection ?? this.langDirection,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lang_code': langCode,
      'lang_name': langName,
      'is_default': isDefault,
      'status': status,
      'lang_direction': langDirection,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      id: map['id'] ?? 0,
      langCode: map['lang_code'] ?? '',
      langName: map['lang_name'] ?? '',
      isDefault: map['is_default'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      langDirection: map['lang_direction'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageModel.fromJson(String source) =>
      LanguageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      langCode,
      langName,
      isDefault,
      status,
      langDirection,
      createdAt,
      updatedAt,
    ];
  }
}

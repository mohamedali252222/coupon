import 'dart:convert';

import 'package:equatable/equatable.dart';

class ScriptContentModel extends Equatable {
  final int id;
  final String regularContent;
  final String extendContent;
  final int status;
  final String createdAt;
  final String updatedAt;

  const ScriptContentModel({
    required this.id,
    required this.regularContent,
    required this.extendContent,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  ScriptContentModel copyWith({
    int? id,
    String? regularContent,
    String? extendContent,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return ScriptContentModel(
      id: id ?? this.id,
      regularContent: regularContent ?? this.regularContent,
      extendContent: extendContent ?? this.extendContent,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'regular_content': regularContent,
      'extend_content': extendContent,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ScriptContentModel.fromMap(Map<String, dynamic> map) {
    return ScriptContentModel(
      id: map['id'] ?? 0,
      regularContent: map['regular_content'] ?? '',
      extendContent: map['extend_content'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ScriptContentModel.fromJson(String source) =>
      ScriptContentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      regularContent,
      extendContent,
      status,
      createdAt,
      updatedAt,
    ];
  }
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

class SinglePartner extends Equatable {
  final int id;
  final String link;
  final String logo;
  final int status;
  final String createdAt;
  final String updatedAt;

  const SinglePartner({
    required this.id,
    required this.link,
    required this.logo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  SinglePartner copyWith({
    int? id,
    String? link,
    String? logo,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return SinglePartner(
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

  factory SinglePartner.fromMap(Map<String, dynamic> map) {
    return SinglePartner(
      id: map['id'] ?? '',
      link: map['link'] ?? '',
      logo: map['logo'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SinglePartner.fromJson(String source) =>
      SinglePartner.fromMap(json.decode(source) as Map<String, dynamic>);

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

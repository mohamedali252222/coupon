import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'single_partner.dart';

class PartnerModel extends Equatable {
  final bool visibility;
  final String title;
  final String description;
  final List<SinglePartner>? partners;

  const PartnerModel({
    required this.visibility,
    required this.title,
    required this.description,
    required this.partners,
  });

  PartnerModel copyWith({
    bool? visibility,
    String? title,
    String? description,
    List<SinglePartner>? partners,
  }) {
    return PartnerModel(
      visibility: visibility ?? this.visibility,
      title: title ?? this.title,
      description: description ?? this.description,
      partners: partners ?? this.partners,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'title': title,
      'description': description,
      'partners': partners!.map((x) => x.toMap()).toList(),
    };
  }

  factory PartnerModel.fromMap(Map<String, dynamic> map) {
    return PartnerModel(
      visibility: map['visibility'] ?? true,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      partners: map['partners'] != null
          ? List<SinglePartner>.from(
              (map['partners'] as List<dynamic>).map<SinglePartner?>(
                (x) => SinglePartner.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PartnerModel.fromJson(String source) =>
      PartnerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [visibility, title, description, partners!];
}

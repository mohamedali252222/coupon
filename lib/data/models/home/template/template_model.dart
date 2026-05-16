// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'single_template_model.dart';

class TemplateModel extends Equatable {
  final bool visibility;
  final String title;
  final String description;
  final List<SingleTemplateModel>? templates;
  const TemplateModel({
    required this.visibility,
    required this.title,
    required this.description,
    this.templates,
  });

  TemplateModel copyWith({
    bool? visibility,
    String? title,
    String? description,
    List<SingleTemplateModel>? templates,
  }) {
    return TemplateModel(
      visibility: visibility ?? this.visibility,
      title: title ?? this.title,
      description: description ?? this.description,
      templates: templates ?? this.templates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'title': title,
      'description': description,
      'templates': templates!.map((x) => x.toMap()).toList(),
    };
  }

  factory TemplateModel.fromMap(Map<String, dynamic> map) {
    return TemplateModel(
      visibility: map['visibility'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      templates: map['templates'] != null
          ? List<SingleTemplateModel>.from(
              (map['templates'] as List<dynamic>).map<SingleTemplateModel?>(
                (x) => SingleTemplateModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory TemplateModel.fromJson(String source) =>
      TemplateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [visibility, title, description, templates!];
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'home_single_category_model.dart';

class CategoryModel extends Equatable {
  final bool visibility;
  final String title;
  final String description;
  final List<SingleCategoryModel>? categories;

  const CategoryModel({
    required this.visibility,
    required this.title,
    required this.description,
    required this.categories,
  });

  CategoryModel copyWith({
    bool? visibility,
    String? title,
    String? description,
    List<SingleCategoryModel>? categories,
  }) {
    return CategoryModel(
      visibility: visibility ?? this.visibility,
      title: title ?? this.title,
      description: description ?? this.description,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'title': title,
      'description': description,
      'categories': categories!.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      visibility: map['visibility'] ?? true,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      categories: map['categories'] != null
          ? List<SingleCategoryModel>.from(
              (map['categories'] as List<dynamic>).map<SingleCategoryModel?>(
                (x) => SingleCategoryModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        visibility,
        categories!,
        title,
        description,
      ];
}

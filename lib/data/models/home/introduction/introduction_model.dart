import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../category/home_single_category_model.dart';
import 'content_model.dart';

class IntroductionModel extends Equatable {
  final bool visibility;
  final ContentModel? content;
  final List<SingleCategoryModel>? categories;

  const IntroductionModel({
    required this.visibility,
    required this.content,
    required this.categories,
  });

  IntroductionModel copyWith(
      {bool? visibility,
      ContentModel? content,
      List<SingleCategoryModel>? categories}) {
    return IntroductionModel(
      visibility: visibility ?? this.visibility,
      content: content ?? this.content,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'content': content!.toMap(),
      'categories': categories!.map((e) => e.toMap()).toList(),
    };
  }

  factory IntroductionModel.fromMap(Map<String, dynamic> map) {
    return IntroductionModel(
      visibility: map['visibility'] ?? true,
      content: map['content'] != null
          ? ContentModel.fromMap(map['content'] as Map<String, dynamic>)
          : null,
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

  factory IntroductionModel.fromJson(String source) =>
      IntroductionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        visibility,
        content!,
        categories!,
      ];
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

class FaqContent extends Equatable {
  final int id;
  final int status;
  final String createdAt;
  final String updatedAt;
  final SingleFaqContent? faqContent;

  const FaqContent({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.faqContent,
  });

  FaqContent copyWith(
      {int? id,
      int? status,
      String? createdAt,
      String? updatedAt,
      SingleFaqContent? faqContent}) {
    return FaqContent(
      id: id ?? this.id,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      faqContent: faqContent ?? this.faqContent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'faqlangfrontend': faqContent!.toMap(),
    };
  }

  factory FaqContent.fromMap(Map<String, dynamic> map) {
    return FaqContent(
      id: map['id'] ?? 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      faqContent: map['faqlangfrontend'] != null
          ? SingleFaqContent.fromMap(
              map['faqlangfrontend'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FaqContent.fromJson(String source) =>
      FaqContent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      status,
      createdAt,
      updatedAt,
      faqContent!,
    ];
  }
}

class SingleFaqContent extends Equatable {
  final int id;
  final String question;
  final String answer;
  final int faqId;
  final String langCode;
  final int status;
  final String createdAt;
  final String updatedAt;

  SingleFaqContent copyWith({
    int? id,
    String? question,
    String? answer,
    int? faqId,
    String? langCode,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return SingleFaqContent(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      faqId: faqId ?? this.faqId,
      langCode: langCode ?? this.langCode,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  const SingleFaqContent({
    required this.id,
    required this.question,
    required this.faqId,
    required this.langCode,
    required this.answer,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'answer': answer,
      'faq_id': faqId,
      'lang_code': langCode,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SingleFaqContent.fromMap(Map<String, dynamic> map) {
    return SingleFaqContent(
      id: map['id'] ?? 0,
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      langCode: map['lang_code'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      faqId: map['faq_id'] != null ? int.parse(map['faq_id'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleFaqContent.fromJson(String source) =>
      SingleFaqContent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      question,
      answer,
      status,
      faqId,
      langCode,
      createdAt,
      updatedAt,
    ];
  }
}

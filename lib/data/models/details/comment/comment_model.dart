import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'single_comment_model.dart';

class CommentModel extends Equatable {
  final int currentPage;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final String lastPageUrl;
  final int to;
  final int total;
  final List<SingleCommentModel>? data;

  const CommentModel({
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.lastPageUrl,
    required this.to,
    required this.total,
    required this.data,
  });

  CommentModel copyWith({
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? nextPageUrl,
    String? path,
    int? perPage,
    String? prevPageUrl,
    String? lastPageUrl,
    int? to,
    int? total,
    List<SingleCommentModel>? data,
  }) {
    return CommentModel(
      currentPage: currentPage ?? this.currentPage,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      to: to ?? this.to,
      total: total ?? this.total,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'current_page': currentPage,
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'last_page_url': lastPageUrl,
      'to': to,
      'total': total,
      'data': data!.map((x) => x.toMap()).toList(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      currentPage: map['current_page'] != null
          ? int.parse(map['current_page'].toString())
          : 0,
      firstPageUrl: map['first_page_url'] ?? '',
      from: map['from'] != null ? int.parse(map['current_page'].toString()) : 0,
      lastPage:
          map['last_page'] != null ? int.parse(map['last_page'].toString()) : 0,
      nextPageUrl: map['next_page_url'] ?? '',
      path: map['path'] ?? '',
      perPage:
          map['per_page'] != null ? int.parse(map['per_page'].toString()) : 0,
      prevPageUrl: map['prev_page_url'] ?? '',
      lastPageUrl: map['last_page_url'] ?? '',
      to: map['to'] != null ? int.parse(map['to'].toString()) : 0,
      total: map['total'] != null ? int.parse(map['total'].toString()) : 0,
      data: map['data'] != null
          ? List<SingleCommentModel>.from(
              (map['data'] as List<dynamic>).map<SingleCommentModel>(
                (x) => SingleCommentModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      currentPage,
      firstPageUrl,
      from,
      lastPage,
      nextPageUrl,
      path,
      perPage,
      prevPageUrl,
      lastPageUrl,
      to,
      total,
      data!,
    ];
  }
}

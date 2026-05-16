// import 'dart:convert';
//
// import 'package:equatable/equatable.dart';
//
// import '../details/product_item_model.dart';
// import '../home/product/link_model.dart';
//
// class SingleSearchModel extends Equatable {
//   final int currentPage;
//   final List<ProductItemModel>? data;
//   final String firstPageUrl;
//   final int from;
//   final int lastPage;
//   final String lastPageUrl;
//   final String nextPageUrl;
//   final List<LinkModel>? link;
//   final String path;
//   final int perPage;
//   final String prevPageUrl;
//   final int to;
//   final int total;
//
//   const SingleSearchModel({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     required this.nextPageUrl,
//     required this.link,
//     required this.path,
//     required this.perPage,
//     required this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });
//
//   SingleSearchModel copyWith({
//     int? currentPage,
//     List<ProductItemModel>? data,
//     String? firstPageUrl,
//     int? from,
//     int? lastPage,
//     String? lastPageUrl,
//     String? nextPageUrl,
//     List<LinkModel>? link,
//     String? path,
//     int? perPage,
//     String? prevPageUrl,
//     int? to,
//     int? total,
//   }) {
//     return SingleSearchModel(
//       currentPage: currentPage ?? this.currentPage,
//       data: data ?? this.data,
//       firstPageUrl: firstPageUrl ?? this.firstPageUrl,
//       from: from ?? this.from,
//       lastPage: lastPage ?? this.lastPage,
//       lastPageUrl: lastPageUrl ?? this.lastPageUrl,
//       nextPageUrl: nextPageUrl ?? this.nextPageUrl,
//       link: link ?? this.link,
//       path: path ?? this.path,
//       perPage: perPage ?? this.perPage,
//       prevPageUrl: prevPageUrl ?? this.prevPageUrl,
//       to: to ?? this.to,
//       total: total ?? this.total,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'current_page': currentPage,
//       'first_page_url': firstPageUrl,
//       'from': from,
//       'last_page': lastPage,
//       'last_page_url': lastPageUrl,
//       'next_page_url': nextPageUrl,
//       'link': link!.map((x) => x.toMap()).toList(),
//       'path': path,
//       'per_page': perPage,
//       'prev_page_url': prevPageUrl,
//       'to': to,
//       'total': total,
//       'data': data!.map((x) => x.toMap()).toList(),
//     };
//   }
//
//   factory SingleSearchModel.fromMap(Map<String, dynamic> map) {
//     return SingleSearchModel(
//       currentPage: map['current_page'] != null
//           ? int.parse(map['current_page'].toString())
//           : 0,
//       firstPageUrl: map['first_page_url'] ?? '',
//       from: map['from'] != null ? int.parse(map['from'].toString()) : 0,
//       lastPage:
//           map['last_page'] != null ? int.parse(map['last_page'].toString()) : 0,
//       lastPageUrl: map['last_page_url'] ?? '',
//       nextPageUrl: map['next_page_url'] ?? '',
//       link: map['link'] != null
//           ? List<LinkModel>.from(
//               (map['link'] as List<dynamic>).map<LinkModel>(
//                 (x) => LinkModel.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//       path: map['path'] ?? '',
//       perPage:
//           map['per_page'] != null ? int.parse(map['per_page'].toString()) : 0,
//       prevPageUrl: map['prev_page_url'] ?? '',
//       to: map['to'] != null ? int.parse(map['to'].toString()) : 0,
//       total: map['total'] != null ? int.parse(map['total'].toString()) : 0,
//       data: map['data'] != null
//           ? List<ProductItemModel>.from(
//               (map['data'] as List<dynamic>).map<ProductItemModel>(
//                 (x) => ProductItemModel.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory SingleSearchModel.fromJson(String source) =>
//       SingleSearchModel.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   bool get stringify => true;
//
//   @override
//   List<Object> get props {
//     return [
//       currentPage,
//       data!,
//       firstPageUrl,
//       from,
//       lastPage,
//       lastPageUrl,
//       nextPageUrl,
//       link!,
//       path,
//       perPage,
//       prevPageUrl,
//       to,
//       total,
//     ];
//   }
// }

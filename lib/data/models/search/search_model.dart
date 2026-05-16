import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../details/product_item_model.dart';

class SearchResponseModel extends Equatable {
  //final SingleSearchModel? products;
  final List<ProductItemModel>? products;
  final double minPrice;
  final double maxPrice;
  final double productMaxPrice;
  final int currentPage;
  final int from;
  final int lastPage;
  final int perPage;
  final int to;
  final int total;
  final String firstPageUrl;
  final String lastPageUrl;
  final String nextPageUrl;
  final String prevPageUrl;

  const SearchResponseModel({
    //required this.products,
    required this.products,
    required this.minPrice,
    required this.maxPrice,
    required this.productMaxPrice,
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
    required this.firstPageUrl,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.prevPageUrl,
  });

  SearchResponseModel copyWith({
    //SingleSearchModel? products,
    List<ProductItemModel>? products,
    double? minPrice,
    double? maxPrice,
    double? productMaxPrice,
    int? currentPage,
    int? from,
    int? lastPage,
    int? perPage,
    int? to,
    int? total,
    String? firstPageUrl,
    String? lastPageUrl,
    String? nextPageUrl,
    String? prevPageUrl,
  }) {
    return SearchResponseModel(
      //products: products ?? this.products,
      products: products ?? this.products,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      productMaxPrice: productMaxPrice ?? this.productMaxPrice,
      currentPage: currentPage ?? this.currentPage,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      to: to ?? this.to,
      total: total ?? this.total,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'products': products?.toMap(),
      'products': products!.map((x) => x.toMap()).toList(),
      'min_price': minPrice,
      'max_price': maxPrice,
      'product_max_price': productMaxPrice,
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'per_page': perPage,
      'to': to,
      'total': total,
      'first_page_url': firstPageUrl,
      'last_page_url': lastPageUrl,
      'next_page_url': nextPageUrl,
      'prev_page_url': prevPageUrl,
    };
  }

  factory SearchResponseModel.fromMap(Map<String, dynamic> map) {
    return SearchResponseModel(
      // products: map['products'] != null
      //     ? SingleSearchModel.fromMap(map['products'] as Map<String, dynamic>)
      //     : null,
      products: map['products']['data'] != null
          ? List<ProductItemModel>.from(
              (map['products']['data'] as List<dynamic>).map<ProductItemModel>(
                (x) => ProductItemModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      minPrice: map['min_price'] != null
          ? double.parse(map['min_price'].toString())
          : 0.0,
      maxPrice: map['max_price'] != null
          ? double.parse(map['max_price'].toString())
          : 0.0,
      productMaxPrice: map['product_max_price'] != null
          ? double.parse(map['product_max_price'].toString())
          : 0.0,

      currentPage: map['current_page'] != null
          ? int.parse(map['current_page'].toString())
          : 0,
      from: map['from'] != null ? int.parse(map['from'].toString()) : 0,
      lastPage:
          map['last_page'] != null ? int.parse(map['last_page'].toString()) : 0,
      perPage:
          map['per_page'] != null ? int.parse(map['per_page'].toString()) : 0,
      to: map['to'] != null ? int.parse(map['to'].toString()) : 0,
      total: map['total'] != null ? int.parse(map['total'].toString()) : 0,
      firstPageUrl: map['first_page_url'] ?? '',
      lastPageUrl: map['last_page_url'] ?? '',
      nextPageUrl: map['next_page_url'] ?? '',
      prevPageUrl: map['prev_page_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchResponseModel.fromJson(String source) =>
      SearchResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      // products!,
      products!,
      minPrice,
      maxPrice,
      productMaxPrice,
      currentPage,
      from,
      lastPage,
      perPage,
      to,
      total,
      firstPageUrl,
      lastPageUrl,
      nextPageUrl,
      prevPageUrl,
    ];
  }
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../details/product_item_model.dart';

class ProductModel extends Equatable {
  final bool visibility;
  final String title;
  final String description;
  final List<ProductItemModel>? products;

  // final List<SingleProductModel>? products;

  const ProductModel({
    required this.visibility,
    required this.description,
    required this.title,
    required this.products,
  });

  ProductModel copyWith({
    bool? visibility,
    String? title,
    String? description,
    List<ProductItemModel>? products,
  }) {
    return ProductModel(
      visibility: visibility ?? this.visibility,
      title: title ?? this.title,
      description: description ?? this.description,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'title': title,
      'description': description,
      'products': products!.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      visibility: map['visibility'] ?? true,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      products: map['products'] != null
          ? List<ProductItemModel>.from(
              (map['products'] as List<dynamic>).map<ProductItemModel>(
                (x) => ProductItemModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [visibility, products!, title, description];
}

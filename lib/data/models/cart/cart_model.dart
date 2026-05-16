import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../details/product_item_model.dart';
import '../details/variant/variant_model.dart';
import '../home/category/home_single_category_model.dart';
import '../home/product/author_model.dart';

class CartModel extends Equatable {
  final List<CartItemModel>? cartItems;
  final double subTotal;
  final double discount;
  final double total;

  const CartModel({
    required this.cartItems,
    required this.subTotal,
    required this.discount,
    required this.total,
  });

  CartModel copyWith({
    List<CartItemModel>? cartItems,
    double? subTotal,
    double? discount,
    double? total,
  }) {
    return CartModel(
      cartItems: cartItems ?? this.cartItems,
      subTotal: subTotal ?? this.subTotal,
      discount: discount ?? this.discount,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cart_items': cartItems!.map((x) => x.toMap()).toList(),
      'sub_total_amount': subTotal,
      'discount_amount': discount,
      'total_amount': total,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartItems: map['cart_items'] != null
          ? List<CartItemModel>.from(
              (map['cart_items'] as List<dynamic>).map<CartItemModel>(
                (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      subTotal: map['sub_total_amount'] != null
          ? double.parse(map['sub_total_amount'].toString())
          : 0.0,
      discount: map['discount_amount'] != null
          ? double.parse(map['discount_amount'].toString())
          : 0.0,
      total: map['total_amount'] != null
          ? double.parse(map['total_amount'].toString())
          : 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [cartItems!, subTotal, discount, total];
}

class CartItemModel extends Equatable {
  final int id;
  final int userId;
  final int productId;
  final int variantId;
  final int categoryId;
  final String productType;
  final String priceType;
  final int authorId;
  final String createdAt;
  final String updatedAt;
  final AuthorModel? author;
  final SingleCategoryModel? category;
  final VariantModel? variant;
  final ProductItemModel? product;

  const CartItemModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.variantId,
    required this.categoryId,
    required this.productType,
    required this.priceType,
    required this.authorId,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
    required this.category,
    required this.variant,
    required this.product,
  });

  CartItemModel copyWith({
    int? id,
    int? userId,
    int? productId,
    int? variantId,
    int? categoryId,
    String? productType,
    String? priceType,
    int? authorId,
    String? createdAt,
    String? updatedAt,
    AuthorModel? author,
    SingleCategoryModel? category,
    VariantModel? variant,
    ProductItemModel? product,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      categoryId: categoryId ?? this.categoryId,
      productType: productType ?? this.productType,
      priceType: priceType ?? this.priceType,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      author: author ?? this.author,
      category: category ?? this.category,
      variant: variant ?? this.variant,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'variant_id': variantId,
      'category_id': categoryId,
      'product_type': productType,
      'price_type': priceType,
      'author_id': authorId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'author': author!.toMap(),
      'category': category!.toMap(),
      'variant': variant!.toMap(),
      'product': product!.toMap(),
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] ?? 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      variantId: map['variant_id'] != null
          ? int.parse(map['variant_id'].toString())
          : 0,
      categoryId: map['category_id'] != null
          ? int.parse(map['category_id'].toString())
          : 0,
      productType: map['product_type'] ?? '',
      priceType: map['price_type'] ?? '',
      authorId:
          map['author_id'] != null ? int.parse(map['author_id'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      author: map['author'] != null
          ? AuthorModel.fromMap(map['author'] as Map<String, dynamic>)
          : null,
      category: map['category'] != null
          ? SingleCategoryModel.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      variant: map['variant'] != null
          ? VariantModel.fromMap(map['variant'] as Map<String, dynamic>)
          : null,
      product: map['product'] != null
          ? ProductItemModel.fromMap(map['product'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      productId,
      variantId,
      categoryId,
      productType,
      priceType,
      authorId,
      createdAt,
      updatedAt,
      author!,
      category!,
      variant!,
      product!,
    ];
  }
}

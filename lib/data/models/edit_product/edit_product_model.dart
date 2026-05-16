// import 'dart:convert';
//
// import 'package:equatable/equatable.dart';
//
// import '../home/category/home_single_category_model.dart';
//
// class EditProductModel extends Equatable {
//   final List<SingleCategoryModel>? categories;
//   final String productType;
//   final ProductItemModel? product;
//   final List<VariantModel>? variants;
//
//   const EditProductModel({
//     required this.categories,
//     required this.productType,
//     required this.product,
//     required this.variants,
//   });
//
//   EditProductModel copyWith({
//     List<SingleCategoryModel>? categories,
//     String? productType,
//     ProductItemModel? product,
//     List<VariantModel>? variants,
//   }) {
//     return EditProductModel(
//       categories: categories ?? this.categories,
//       productType: productType ?? this.productType,
//       product: product ?? this.product,
//       variants: variants ?? this.variants,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'categories': categories!.map((x) => x.toMap()).toList(),
//       'product_type': productType,
//       'product': product!.toMap(),
//       'product_variants': variants!.map((x) => x.toMap()).toList(),
//     };
//   }
//
//   factory EditProductModel.fromMap(Map<String, dynamic> map) {
//     return EditProductModel(
//       categories: map['categories'] != null
//           ? List<SingleCategoryModel>.from(
//               (map['categories'] as List<dynamic>).map<SingleCategoryModel>(
//                 (x) => SingleCategoryModel.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : [],
//       productType: map['product_type'] ?? '',
//       product: map['product'] != null
//           ? ProductItemModel.fromMap(map['product'] as Map<String, dynamic>)
//           : null,
//       variants: map['product_variants'] != null
//           ? List<VariantModel>.from(
//               (map['product_variants'] as List<dynamic>).map<VariantModel>(
//                 (x) => VariantModel.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : [],
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory EditProductModel.fromJson(String source) =>
//       EditProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   bool get stringify => true;
//
//   @override
//   List<Object> get props => [
//         categories!,
//         productType,
//         product!,
//         variants!,
//       ];
// }

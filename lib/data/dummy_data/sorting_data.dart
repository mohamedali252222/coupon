import 'package:equatable/equatable.dart';

class SortModel extends Equatable {
  final int id;
  final String name;

  const SortModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

final List<SortModel> sortData = [
  const SortModel(id: 1, name: 'Default Sorting'),
  const SortModel(id: 2, name: 'Script Product'),
  const SortModel(id: 3, name: 'Image Product'),
  const SortModel(id: 4, name: 'Audio Product'),
  const SortModel(id: 5, name: 'Video Product'),
];

class ProductType extends Equatable {
  final int id;
  final String type;

  const ProductType({
    required this.id,
    required this.type,
  });

  @override
  List<Object?> get props => [id, type];
}

final List<ProductType> uploadProductTypes = [
  const ProductType(id: 0, type: 'Script'),
  const ProductType(id: 1, type: 'Image'),
  const ProductType(id: 2, type: 'Video'),
  const ProductType(id: 3, type: 'Audio'),
];

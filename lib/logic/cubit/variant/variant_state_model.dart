import 'package:equatable/equatable.dart';

import 'variant_cubit.dart';

class VariantStateModel extends Equatable {
  final String fileName;
  final String variantName;
  final String price;
  final String languageCode;
  final VariantState variantState;

  const VariantStateModel({
    this.fileName = '',
    this.variantName = '',
    this.price = '',
    this.languageCode = '',
    this.variantState = const VariantInitial(),
  });

  VariantStateModel copyWith({
    String? fileName,
    String? variantName,
    String? price,
    String? languageCode,
    VariantState? variantState,
  }) {
    return VariantStateModel(
      fileName: fileName ?? this.fileName,
      variantName: variantName ?? this.variantName,
      price: price ?? this.price,
      languageCode: languageCode ?? this.languageCode,
      variantState: variantState ?? this.variantState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'file_name': fileName,
      'variant_name': variantName,
      'price': price,
      'lang_code': languageCode,
    };
  }

  VariantStateModel clear() {
    return const VariantStateModel(
      fileName: '',
      variantName: '',
      price: '',
      variantState: VariantInitial(),
    );
  }

  @override
  List<Object> get props =>
      [fileName, variantName, price, languageCode, variantState];
}

import 'package:equatable/equatable.dart';

import 'filter_cubit.dart';

class FilterStateModel extends Equatable {
  final String sorting;
  final String minPrice;
  final String maxPrice;
  final String keyword;
  final String category;
  final String currencyRate;
  final String languageCode;
  final FilterState filterState;

  const FilterStateModel({
    this.sorting = '',
    this.minPrice = '',
    this.maxPrice = '',
    this.keyword = '',
    this.category = '',
    this.currencyRate = '1.0',
    this.languageCode = '',
    this.filterState = const FilterInitial(),
  });

  FilterStateModel copyWith({
    String? sorting,
    String? minPrice,
    String? maxPrice,
    String? keyword,
    String? category,
    String? currencyRate,
    String? languageCode,
    FilterState? filterState,
  }) {
    return FilterStateModel(
      sorting: sorting ?? this.sorting,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      keyword: keyword ?? this.keyword,
      category: category ?? this.category,
      currencyRate: currencyRate ?? this.currencyRate,
      languageCode: languageCode ?? this.languageCode,
      filterState: filterState ?? this.filterState,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, String>{};
    result.addAll({'sorting': sorting});
    result.addAll({'category': category});
    result.addAll({'min_price': minPrice});
    result.addAll({'max_price': maxPrice});
    result.addAll({'keyword': keyword});
    result.addAll({'currency_rate': currencyRate});
    result.addAll({'lang_code': languageCode});
    return result;
  }

  static FilterStateModel init() {
    return const FilterStateModel(
      sorting: '',
      minPrice: '',
      maxPrice: '',
      keyword: '',
      category: '',
      languageCode: '',
      currencyRate: '1.0',
      filterState: FilterInitial(),
    );
  }

  FilterStateModel clear() {
    return const FilterStateModel(
      sorting: '',
      minPrice: '',
      maxPrice: '',
      keyword: '',
      category: '',
      languageCode: '',
      currencyRate: '1.0',
      filterState: FilterInitial(),
    );
  }

  @override
  List<Object?> get props => [
        sorting,
        minPrice,
        maxPrice,
        keyword,
        category,
        languageCode,
        currencyRate,
        filterState,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/models/search/search_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/search_repository.dart';
import 'filter_state_model.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterStateModel> {
  final SearchRepository _repository;
  final LoginBloc _loginBloc;

  FilterCubit(
      {required SearchRepository repository, required LoginBloc loginBloc})
      : _repository = repository,
        _loginBloc = loginBloc,
        super(FilterStateModel.init());
  SearchResponseModel? product;

  void changeSorting(String value) {
    emit(state.copyWith(sorting: value));
  }

  void changeCategory(String value) {
    emit(state.copyWith(category: value));
  }

  void changeMinPrice(String value) {
    emit(state.copyWith(minPrice: value));
  }

  void changeMaxPrice(String value) {
    emit(state.copyWith(maxPrice: value));
  }

  void changeKeyword(String value) {
    emit(state.copyWith(keyword: value));
  }

  void changeCurrencyRate(String value) {
    emit(state.copyWith(currencyRate: value));
  }

  Future<void> getAllProductList() async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(filterState: FilterStateLoading()));
    final result = await _repository.getAllProductList(state.languageCode);
    result.fold((failure) {
      final error = FilterStateError(failure.message, failure.statusCode);
      emit(state.copyWith(filterState: error));
    }, (success) {
      product = success;
      emit(state.copyWith(filterState: ProductListLoaded(success)));
    });
  }

  Future<void> getFilterProductByName(String name) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(filterState: FilterStateLoading()));
    final uri =
        Uri.parse(RemoteUrls.getCategoryByName).replace(queryParameters: {
      'category': name,
      'lang_code': state.languageCode,
    });
    print('url-for getFilterProductByName $uri');
    final result = await _repository.getFilterProductByName(uri);
    result.fold((failure) {
      final error = FilterStateError(failure.message, failure.statusCode);
      emit(state.copyWith(filterState: error));
    }, (success) {
      product = success;
      emit(state.copyWith(filterState: ProductListLoaded(success)));
    });
  }

  Future<void> getFilteredProduct() async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(filterState: FilterStateLoading()));
    Uri uri = Uri.parse(RemoteUrls.getCategoryByName)
        .replace(queryParameters: state.toMap());
    print('stateParams: ${state.toMap()}');
    print('uri: $uri');
    final result = await _repository.getFilterProductByName(uri);
    result.fold((failure) {
      final error = FilterStateError(failure.message, failure.statusCode);
      emit(state.copyWith(filterState: error));
    }, (success) {
      product = success;
      emit(state.copyWith(filterState: ProductListLoaded(success)));
      //emit(state.copyWith(filterState: const FilterStateClear('state clear')));
      print('clear all filter data');
    });
  }

  Future<void> clear() async {
    print('clear');
    emit(state.clear());
  }
}

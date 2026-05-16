import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/data_provider/remote_url.dart';
import '../../../data/models/details/product_item_model.dart';
import '../../../data/models/search/search_model.dart';
import '../../cubit/language_code_state.dart';
import '../../repository/search_repository.dart';
import '../login/login_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, LanguageCodeState> {
  final SearchRepository _searchRepository;
  final LoginBloc _loginBloc;

  SearchResponseModel? _searchResponseModel;
  List<ProductItemModel> property = [];

  SearchBloc(
      {required SearchRepository searchRepository,
      required LoginBloc loginBloc})
      : _searchRepository = searchRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState()) {
    on<SearchEventProperty>(_searchProperty);
    on<SearchEventLoadMoreProperty>(_searchMoreProperty);
  }

  Future<void> _searchProperty(
      SearchEventProperty event, Emitter<LanguageCodeState> emit) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(searchState: SearchLoading()));
    final uri = Uri.parse(RemoteUrls.getSearchProperty).replace(
        queryParameters: {
          'keyword': event.name,
          'lang_code': state.languageCode
        });
    debugPrint('search-url $uri');
    final result = await _searchRepository.getSearchProperty(uri);
    result.fold((failure) {
      final errors = SearchError(failure.message, failure.statusCode);
      emit(state.copyWith(searchState: errors));
    }, (success) {
      property = success.products!;
      final successState = SearchLoaded(success.products!);
      emit(state.copyWith(searchState: successState));
    });
  }

  Future<void> _searchMoreProperty(SearchEventLoadMoreProperty event,
      Emitter<LanguageCodeState> emit) async {
    if (state is SearchMorePropertyLoading) return;
    if (_searchResponseModel == null) {
      return;
    }
    emit(state.copyWith(searchState: SearchMorePropertyLoading()));
    final uri = Uri.parse(_searchResponseModel!.nextPageUrl);
    final result = await _searchRepository.getSearchProperty(uri);

    result.fold((failure) {
      final errors =
          SearchMorePropertyError(failure.message, failure.statusCode);
      emit(state.copyWith(searchState: errors));
    }, (success) {
      _searchResponseModel = success;
      property.addAll(success.products!);
      final successState = SearchMorePropertyLoaded(property.toSet().toList());
      emit(state.copyWith(searchState: successState));
    });
  }
}

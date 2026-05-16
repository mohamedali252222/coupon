import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/details/product_item_model.dart';
import '../../../data/models/home/home_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/home_repository.dart';
import '../language_code_state.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<LanguageCodeState> {
  final HomeRepository _homeRepository;
  final LoginBloc _loginBloc;

  HomeCubit({
    required HomeRepository homeRepository,
    required LoginBloc loginBloc,
  })  : _homeRepository = homeRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState()) {
    _loginBloc.stream.listen((loginState) {
      if (loginState.languageCode.isNotEmpty) {
        getHomeData(); // Fetch new data when language code changes
      }
    });
    getHomeData(); // Initial fetch
  }

  HomeModel? homeModel;
  List<ProductItemModel> bestProduct = [];

  Future<void> getHomeData() async {
    emit(state.copyWith(homeState: HomeStateLoading()));
    debugPrint(
        'Fetching home data for language: ${_loginBloc.state.languageCode}');

    final result =
        await _homeRepository.getHomeData(_loginBloc.state.languageCode);

    result.fold(
      (failure) {
        final errorState = HomeStateError(failure.message, failure.statusCode);
        emit(state.copyWith(homeState: errorState));
      },
      (success) {
        homeModel = success;
        final successState = HomeStateLoaded(success);
        emit(state.copyWith(homeState: successState));
      },
    );
  }

  Future<void> getBestSellingProduct() async {
    emit(state.copyWith(homeState: HomeStateLoading()));
    final result = await _homeRepository
        .getBestSellingProduct(_loginBloc.state.languageCode);
    result.fold(
      (failure) {
        final errorState = HomeStateError(failure.message, failure.statusCode);
        emit(state.copyWith(homeState: errorState));
      },
      (success) {
        bestProduct = success;
        final successState = HomeStateBestSellingLoaded(success);
        emit(state.copyWith(homeState: successState));
      },
    );
  }
}

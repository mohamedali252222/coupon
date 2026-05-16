import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/details/product_item_model.dart';
import '../../../data/models/search/search_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/dashboard_repository.dart';
import '../language_code_state.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<LanguageCodeState> {
  final DashboardRepository _dashboardRepository;
  final LoginBloc _loginBloc;
  SearchResponseModel? portfolio;
  List<ProductItemModel> product = [];

  DashboardCubit({
    required DashboardRepository dashboardRepository,
    required LoginBloc loginBloc,
  })  : _dashboardRepository = dashboardRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState());

  Future<void> getUserPortfolio() async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(dashboardState: DashboardUserPortfolioLoading()));

    final result = await _dashboardRepository.getUserPortfolio(
        _loginBloc.userInformation!.accessToken, state.languageCode);
    result.fold((failure) {
      final errors =
          DashboardUserPortfolioError(failure.message, failure.statusCode);
      emit(state.copyWith(dashboardState: errors));
    }, (success) {
      portfolio = success;
      emit(state.copyWith(
          dashboardState: DashboardUserPortfolioLoaded(success)));
    });
  }

  Future<void> deleteProduct(String id) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }

    emit(state.copyWith(dashboardState: DashboardProductDeleting()));
    final result = await _dashboardRepository.deleteProduct(
        _loginBloc.userInformation!.accessToken, id, state.languageCode);
    result.fold((failure) {
      final errors =
          DashboardDeleteProductError(failure.message, failure.statusCode);
      emit(state.copyWith(dashboardState: errors));
      return false;
    }, (delete) {
      getUserPortfolio();
      product.removeWhere((element) => element.id.toString() == id);
      emit(state.copyWith(dashboardState: DashboardProductDeleted(delete)));
      return true;
    });
  }
}

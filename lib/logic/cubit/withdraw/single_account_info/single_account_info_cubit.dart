import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/withdraw/account_info_model.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../repository/withdraw_repository.dart';
import '../../language_code_state.dart';

part 'single_account_info_state.dart';

class SingleAccountInfoCubit extends Cubit<LanguageCodeState> {
  final WithdrawRepository _withdrawRepository;
  final LoginBloc _loginBloc;

  SingleAccountInfoCubit(
      {required WithdrawRepository withdrawRepository,
      required LoginBloc loginBloc})
      : _withdrawRepository = withdrawRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState());

  Future<void> getAccountInformation(String id) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(accountInfoState: SingleAccountInfoLoading()));

    final account = await _withdrawRepository.getAccountInformation(
        id, _loginBloc.userInformation!.accessToken, state.languageCode);
    account.fold((failure) {
      final errors =
          SingleAccountInfoError(failure.message, failure.statusCode);
      emit(state.copyWith(accountInfoState: errors));
    }, (accountInfo) {
      emit(state.copyWith(
          accountInfoState: SingleAccountInfoLoaded(accountInfo)));
    });
  }
}

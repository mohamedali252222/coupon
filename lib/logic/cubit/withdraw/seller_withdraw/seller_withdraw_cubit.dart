import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/withdraw/method_model.dart';
import '../../../../data/models/withdraw/seller_withdraw_info.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../repository/withdraw_repository.dart';
import '../../language_code_state.dart';

part 'seller_withdraw_state.dart';

class SellerWithdrawCubit extends Cubit<LanguageCodeState> {
  final WithdrawRepository _withdrawRepository;
  final LoginBloc _loginBloc;

  List<MethodModel> withdrawMethods = [];
  SellerWithdrawInfo? withdrawInfo;

  SellerWithdrawCubit(
      {required WithdrawRepository withdrawRepository,
      required LoginBloc loginBloc})
      : _withdrawRepository = withdrawRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState());

  Future<void> getSellerWithdraw() async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(sellerWithdrawState: SellerWithdralLoading()));

    final account = await _withdrawRepository.getSellerAllWithdrawInfo(
        _loginBloc.userInformation!.accessToken, state.languageCode);
    account.fold((failure) {
      final errors = SellerWithdrawError(failure.message, failure.statusCode);
      emit(state.copyWith(sellerWithdrawState: errors));
    }, (success) {
      // withdrawListModel = methodList;
      withdrawInfo = success;
      withdrawMethods = success.withdrawMethods;
      emit(state.copyWith(sellerWithdrawState: SellerWithdrawLoaded(success)));
    });
  }
}

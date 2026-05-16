import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/models/payment/payment_model.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/cart_repository.dart';
import '../language_code_state.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<LanguageCodeState> {
  final CartRepository _repository;
  final LoginBloc _loginBloc;

  PaymentCubit(
      {required CartRepository cartRepository, required LoginBloc loginBloc})
      : _repository = cartRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState()) {
    getPaymentPageInformation();
  }

  PaymentModel? payment;
  final transactionController = TextEditingController();

  Future<void> getPaymentPageInformation() async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    emit(state.copyWith(paymentState: PaymentStateInfoLoading()));
    final result = await _repository.getPaymentPageInformation(
        _loginBloc.userInformation!.accessToken, state.languageCode);
    result.fold((failure) {
      final errors = PaymentStateInfoError(failure.message, failure.statusCode);
      emit(state.copyWith(paymentState: errors));
    }, (success) {
      payment = success;
      emit(state.copyWith(paymentState: PaymentStateInfoLoaded(success)));
    });
  }

  Future<void> bankPayment(String coupon) async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    emit(state.copyWith(paymentState: PaymentStateInfoLoading()));
    // final uri = Uri.parse(
    //         RemoteUrls.bankPayment(_loginBloc.userInformation!.accessToken))
    //     .replace(queryParameters: {
    //   "tnx_info": transactionController.text.trim(),
    //   'coupon_code': couponDto.couponName,
    //   'coupon_amount': couponDto.discount
    // });
    final body = {"tnx_info": transactionController.text.trim()};
    final uri =
        Uri.parse(RemoteUrls.bankPayment + coupon).replace(queryParameters: {
      'token': _loginBloc.userInformation!.accessToken,
      'lang_code': state.languageCode
    });
    print('bank-body $uri');
    final result = await _repository.bankPayment(uri, body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        emit(state.copyWith(
            paymentState: PaymentStateFormError(failure.errors)));
      } else {
        emit(state.copyWith(
            paymentState:
                PaymentStateInfoError(failure.message, failure.statusCode)));
      }
    }, (success) {
      emit(state.copyWith(paymentState: BankPaymentLoaded(success)));
    });
  }
}

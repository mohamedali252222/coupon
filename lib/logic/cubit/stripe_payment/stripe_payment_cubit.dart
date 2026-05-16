import 'package:equatable/equatable.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../../state_packages_name.dart';
import '../../repository/cart_repository.dart';
import 'stripe_payment_state_model.dart';

part 'stripe_payment_state.dart';

class StripePaymentCubit extends Cubit<StripePaymentStateModel> {
  final LoginBloc _loginBloc;
  final CartRepository _paymentRepository;

  StripePaymentCubit(
      {required LoginBloc loginBloc, required CartRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        _loginBloc = loginBloc,
        super(const StripePaymentStateModel());

  void cardNumberChange(String text) {
    emit(state.copyWith(
        cardNumber: text, paymentState: const StripePaymentInitial()));
  }

  void yearChange(String text) {
    emit(
        state.copyWith(year: text, paymentState: const StripePaymentInitial()));
  }

  void monthChange(String text) {
    emit(state.copyWith(
        month: text, paymentState: const StripePaymentInitial()));
  }

  void cvcChange(String text) {
    emit(state.copyWith(cvc: text, paymentState: const StripePaymentInitial()));
  }

  Future<void> stripePayment(String coupon) async {
    emit(state.copyWith(paymentState: const StripePaymentLoading()));
    final uri = Uri.parse(
        RemoteUrls.stripePayment(_loginBloc.userInformation!.accessToken) +
            coupon);
    print('url: $uri');
    print('stripePaymentBody: $state');
    final result = await _paymentRepository.stripePayment(uri, state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = StripePaymentFormError(failure.errors);
        emit(state.copyWith(paymentState: errors));
      } else {
        final errors = StripePaymentError(failure.message, failure.statusCode);
        emit(state.copyWith(paymentState: errors));
      }
    }, (success) {
      emit(state.copyWith(paymentState: StripePaymentLoaded(success)));
      emit(state.clear());
    });
  }
}

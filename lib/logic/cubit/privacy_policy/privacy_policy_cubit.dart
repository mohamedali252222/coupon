import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/faq/faq_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/general_repository.dart';
import '../language_code_state.dart';

part 'privacy_policy_state.dart';

class PrivacyPolicyCubit extends Cubit<LanguageCodeState> {
  final GeneralRepository _repository;
  final LoginBloc _loginBloc;

  PrivacyPolicyCubit(
      {required GeneralRepository repository, required LoginBloc loginBloc})
      : _repository = repository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState()) {
    // getPrivacyPolicy();
    // getTermsAndCondition();
  }

  List<FaqContent> faqContent = [];
  String? privacyText;
  String? termsConditionText;

  Future<void> getFaqContent() async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    emit(state.copyWith(privacyPolicyState: PrivacyPolicyLoading()));
    final result =
        await _repository.getFaqContent(_loginBloc.state.languageCode);
    result.fold((failure) {
      final errorState =
          PrivacyPolicyError(failure.message, failure.statusCode);
      emit(state.copyWith(privacyPolicyState: errorState));
    }, (success) {
      faqContent = success;
      emit(state.copyWith(privacyPolicyState: FaqContentLoaded(success)));
    });
  }

  Future<void> getPrivacyPolicy() async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    emit(state.copyWith(privacyPolicyState: PrivacyPolicyLoading()));
    final result =
        await _repository.getPrivacyPolicy(_loginBloc.state.languageCode);
    result.fold((failure) {
      final errorState =
          PrivacyPolicyError(failure.message, failure.statusCode);
      emit(state.copyWith(privacyPolicyState: errorState));
    }, (success) {
      privacyText = success;
      emit(state.copyWith(privacyPolicyState: PrivacyPolicyLoaded(success)));
    });
  }

  Future<void> getTermsAndCondition() async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    emit(state.copyWith(privacyPolicyState: PrivacyPolicyLoading()));
    final result =
        await _repository.getTermsAndCondition(_loginBloc.state.languageCode);
    result.fold((failure) {
      final errorState =
          PrivacyPolicyError(failure.message, failure.statusCode);
      emit(state.copyWith(privacyPolicyState: errorState));
    }, (success) {
      termsConditionText = success;
      emit(
          state.copyWith(privacyPolicyState: TermsAndConditionLoaded(success)));
    });
  }
}

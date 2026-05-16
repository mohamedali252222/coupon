import 'dart:async';

import 'package:alas_mart/presentation/errors/errors_model.dart';
import 'package:alas_mart/presentation/errors/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_bloc.dart';
import '../../repository/profile_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStateModel> {
  ChangePasswordCubit({
    required ProfileRepository profileRepository,
    required LoginBloc loginBloc,
  })  : _profileRepository = profileRepository,
        _loginBloc = loginBloc,
        super(ChangePasswordStateModel.init());

  final ProfileRepository _profileRepository;
  final LoginBloc _loginBloc;

  void changeCurrentPassword(String value) {
    emit(state.copyWith(
      currentPassword: value,
      passwordChangeState: const ChangePasswordStateInitial(),
    ));
  }

  void changeNewPassword(String value) {
    emit(state.copyWith(
      newPassword: value,
      passwordChangeState: const ChangePasswordStateInitial(),
    ));
  }

  void changeConPassword(String value) {
    emit(state.copyWith(
      confirmationPassword: value,
      passwordChangeState: const ChangePasswordStateInitial(),
    ));
  }

  void showPassword() {
    emit(state.copyWith(showCurrentPassword: !state.showCurrentPassword));
  }

  void showConPassword() {
    emit(state.copyWith(showConPassword: !state.showConPassword));
  }

  void showNewPassword() {
    emit(state.copyWith(showNewPassword: !state.showNewPassword));
  }

  Future<void> submitForm() async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }

    emit(state.copyWith(
        passwordChangeState: const ChangePasswordStateLoading()));

    final token = _loginBloc.userInformation!.accessToken;

    final result = await _profileRepository.passwordChange(
        state, token, state.languageCode);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final currentState = ChangePasswordFormError(failure.errors);
          emit(state.copyWith(passwordChangeState: currentState));
        } else {
          final currentState =
              ChangePasswordStateError(failure.message, failure.statusCode);
          emit(state.copyWith(passwordChangeState: currentState));
        }
      },
      (success) {
        final currentState = ChangePasswordStateLoaded(success);
        emit(state.copyWith(passwordChangeState: currentState));
      },
    );
  }

  FutureOr<void> clearField() {
    emit(state.clear());
  }
}

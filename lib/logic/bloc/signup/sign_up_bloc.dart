import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../repository/auth_repository.dart';
import 'sign_up_state_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpStateModel> {
  final AuthRepository _authRepository;
  TextEditingController pinController = TextEditingController();

  SignUpBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignUpStateModel()) {
    on<SignUpEventName>((event, emit) {
      emit(state.copyWith(
          name: event.name, signUpState: const SignUpStateInitial()));
    });
    on<SignUpEventEmail>((event, emit) {
      emit(state.copyWith(
          email: event.email, signUpState: const SignUpStateInitial()));
    });

    on<SignUpEventVerificationCode>((event, emit) {
      emit(state.copyWith(
          token: event.code, signUpState: const SignUpStateInitial()));
    });

    on<SignUpEventLanguageCode>((event, emit) {
      emit(state.copyWith(
          languageCode: event.languageCode,
          signUpState: const SignUpStateInitial()));
    });

    on<SignUpEventNewUserVerification>((event, emit) {
      emit(state.copyWith(
          token: event.token, signUpState: const SignUpStateInitial()));
    });

    on<SignUpEventPassword>((event, emit) {
      emit(state.copyWith(
          password: event.password, signUpState: const SignUpStateInitial()));
    });
    on<SignUpEventPasswordConfirm>((event, emit) {
      emit(state.copyWith(
          confirmPassword: event.passwordConfirm,
          signUpState: const SignUpStateInitial()));
    });

    on<SignUpEventShowPassword>((event, emit) {
      emit(state.copyWith(
        showPassword: !(event.isShow),
        signUpState: const SignUpStateInitial(),
      ));
    });

    on<SignUpEventShowConfirmPassword>((event, emit) {
      emit(state.copyWith(
        showConfirmPassword: !(event.isShow),
        signUpState: const SignUpStateInitial(),
      ));
    });

    // on<SignUpEventAgree>((event, emit) {
    //   emit(state.copyWith(agree: event.agree));
    // });

    // on<SignUpEventAgree>((event, emit) {
    //   emit(state.copyWith(agree: event.agree));
    // });
    on<SignUpEventSubmit>(_submitForm);

    on<SignUpEventNewUserSubmit>(_newUserVerification);
    on<SignUpEventResendVerificationSubmit>(_resendVerificationCode);
    on<SignUpEventFormDataClear>(_resetSignUpData);
  }

  // Future<void> _clearFormData(
  //     SignUpEventFormDataClear event, Emitter<SignUpStateModel> emit) async {
  //   emit(state.clear());
  // }

  Future<void> _submitForm(
      SignUpEventSubmit event, Emitter<SignUpStateModel> emit) async {
    emit(state.copyWith(signUpState: const SignUpStateLoading()));
    print('body data $state');

    final result = await _authRepository.userRegistration(state);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = SignUpStateFormValidate(failure.errors);
          emit(state.copyWith(signUpState: errors));
        } else {
          final error = SignUpStateError(failure.message, failure.statusCode);
          emit(state.copyWith(signUpState: error));
        }
      },
      (user) {
        //log(user.toString(), name: "SignUpBloc Success");
        emit(state.copyWith(signUpState: SignUpStateLoaded(user)));
      },
    );
  }

  Future<void> _newUserVerification(
      SignUpEventNewUserSubmit event, Emitter<SignUpStateModel> emit) async {
    emit(state.copyWith(signUpState: const SignUpStateLoading()));
    print('verification body $state');
    final result = await _authRepository.newUserVerification(state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = SignUpStateFormValidate(failure.errors);
        emit(state.copyWith(signUpState: errors));
      } else {
        final errors = SignUpStateError(failure.message, failure.statusCode);
        emit(state.copyWith(signUpState: errors));
      }
    }, (success) {
      emit(state.copyWith(
          signUpState: SignUpStateNewUserVerificationLoaded(success)));
    });
  }

  Future<void> _resendVerificationCode(
      SignUpEventResendVerificationSubmit event,
      Emitter<SignUpStateModel> emit) async {
    emit(state.copyWith(signUpState: const SignUpStateResendCodeLoading()));
    final body = {'email': state.email, 'lang_code': state.languageCode};
    print('verification email $body');
    final result = await _authRepository.resendVerificationCode(body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = SignUpStateFormValidate(failure.errors);
        emit(state.copyWith(signUpState: errors));
      } else {
        final errors = SignUpStateError(failure.message, failure.statusCode);
        emit(state.copyWith(signUpState: errors));
      }
    }, (success) {
      emit(state.copyWith(signUpState: SignUpStateResendCodeLoaded(success)));
    });
  }

  FutureOr<void> _resetSignUpData(
      SignUpEventFormDataClear event, Emitter<SignUpStateModel> emit) async {
    emit(state.copyWith(name: ''));
    emit(state.copyWith(email: ''));
    emit(state.copyWith(password: ''));
    emit(state.copyWith(confirmPassword: ''));
  }
// Future<void> _accountActivateCode(
//   AccountActivateCodeSubmit event,
//   Emitter<SignUpStateModel> emit,
// ) async {
//   emit(state.copyWith(state: const SignUpStateLoading()));
//   final map = {'email': state.email, 'token': event.code};
//   print('map $map');
//   final result = await _authRepository.activeAccountCodeSubmit(map);
//
//   result.fold(
//     (Failure failure) {
//       final error = SignUpStateFormError(failure.message, failure.statusCode);
//       emit(state.copyWith(state: error));
//     },
//     (String success) {
//       final loadedData = AccountActivateSuccess(success);
//       emit(state.copyWith(state: loadedData));
//     },
//   );
// }

// Future<void> _resendCodeEvent(
//   SignUpEventResendCodeSubmit event,
//   Emitter<SignUpStateModel> emit,
// ) async {
//   emit(state.copyWith(state: const SignUpStateLoading()));
//   final map = {'email': event.email};
//   final result = await repository.resendVerificationCode(map);
//   result.fold((failure) {
//     if (failure is InvalidAuthData) {
//       emit(state.copyWith(state: SignUpStateLoadedError(failure.errors)));
//     } else {
//       emit(state.copyWith(
//           state: SignUpStateFormError(failure.message, failure.statusCode)));
//     }
//   }, (success) {
//     emit(state.copyWith(state: ResendCodeState(success)));
//   });
// }
}

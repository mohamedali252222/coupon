import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/models/auth_response/user_response_model.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../repository/auth_repository.dart';
import 'login_state_model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStateModel> {
  final AuthRepository _authRepository;
  UserResponseModel? _users;

  bool get isLoggedIn => _users != null && _users!.accessToken.isNotEmpty;

  UserResponseModel? get userInformation => _users;

  set saveUserData(UserResponseModel usersData) => _users = usersData;

  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginStateModel()) {
    on<LoginEventUserEmail>(_onEmailChanged);
    on<LoginEventPassword>(_onPasswordChanged);
    on<LoginEventLanguageCode>(_onLanguageCodeChanged);
    on<LangCodeClear>(_onLangCodeClear);
    on<LoginEventCurrencyIcon>(_onCurrencyIconChanged);
    on<SaveUserCredentialEvent>(_onSaveUserCredential);
    on<LoginEventShowPassword>(_onShowPasswordToggled);
    on<LoginEventRememberMe>(_onRememberMeToggled);
    on<LoginEventSubmit>(_submitLoginEvent);
    on<LoginEventLogout>(_logoutEvent);

    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final result = await _authRepository.getExistingUserInfo();
    result.fold(
      (failure) => _users = null,
      (success) {
        saveUserData = success;
        print('Loaded user data: $success');
      },
    );
  }

  void _onEmailChanged(
      LoginEventUserEmail event, Emitter<LoginStateModel> emit) {
    emit(state.copyWith(
        email: event.email, loginState: const LoginStateInitial()));
  }

  void _onPasswordChanged(
      LoginEventPassword event, Emitter<LoginStateModel> emit) {
    emit(state.copyWith(
        password: event.password, loginState: const LoginStateInitial()));
  }

  void _onLanguageCodeChanged(
      LoginEventLanguageCode event, Emitter<LoginStateModel> emit) {
    print("Language code changed to ${event.languageCode}");
    emit(state.copyWith(
        languageCode: event.languageCode,
        loginState: const LoginStateInitial()));
  }

  void _onLangCodeClear(LangCodeClear event, Emitter<LoginStateModel> emit) {
    print('Language code cleared');
    emit(state.copyWith(languageCode: ''));
  }

  void _onCurrencyIconChanged(
      LoginEventCurrencyIcon event, Emitter<LoginStateModel> emit) {
    emit(state.copyWith(
        currencyIcon: event.currencyIcon,
        loginState: const LoginStateInitial()));
  }

  void _onSaveUserCredential(
      SaveUserCredentialEvent event, Emitter<LoginStateModel> emit) {
    emit(state.copyWith(
        isActive: event.isActive, loginState: const LoginStateInitial()));
  }

  void _onShowPasswordToggled(
      LoginEventShowPassword event, Emitter<LoginStateModel> emit) {
    emit(state.copyWith(
        showPassword: !state.showPassword,
        loginState: const LoginStateInitial()));
  }

  void _onRememberMeToggled(
      LoginEventRememberMe event, Emitter<LoginStateModel> emit) {
    emit(state.copyWith(
        isRemember: !state.isRemember, loginState: const LoginStateInitial()));
  }

  Future<void> _submitLoginEvent(
      LoginEventSubmit event, Emitter<LoginStateModel> emit) async {
    emit(state.copyWith(loginState: LoginStateLoading()));
    print(
        'Submitting login with email: ${state.email} and password: ${state.password}');

    final result = await _authRepository.login(state);
    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          emit(state.copyWith(
              loginState: LoginStateFormValidate(failure.errors)));
        } else {
          emit(state.copyWith(
              loginState: LoginStateError(
                  message: failure.message, statusCode: failure.statusCode)));
        }
      },
      (success) {
        _users = success;
        emit(state.copyWith(
            loginState: LoginStateLoaded(userResponseModel: success)));
      },
    );
  }

  Future<void> _logoutEvent(
      LoginEventLogout event, Emitter<LoginStateModel> emit) async {
    emit(state.copyWith(loginState: LoginStateLogoutLoading()));
    final url = Uri.parse(RemoteUrls.logout).replace(queryParameters: {
      'token': userInformation?.accessToken ?? '',
      'lang_code': state.languageCode,
    });

    debugPrint('Logout URL: $url');
    final result = await _authRepository.logout(url);
    result.fold(
      (failure) {
        emit(state.copyWith(
            loginState:
                LoginStateLogoutError(failure.message, failure.statusCode)));
      },
      (logout) {
        _users = null;
        emit(state.copyWith(loginState: LoginStateLogoutLoaded(logout, 200)));
      },
    );
  }

  Future<void> saveUserCredentials(String email, String password) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('email', email);
    await pref.setString('password', password);
  }

  Future<void> remoteCredentials() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('email');
    await pref.remove('password');
  }
}

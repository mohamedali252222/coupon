part of 'change_password_cubit.dart';

class ChangePasswordStateModel extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmationPassword;
  final String languageCode;
  final bool showCurrentPassword;
  final bool showNewPassword;
  final bool showConPassword;
  final ChangePasswordState passwordChangeState;

  const ChangePasswordStateModel({
    required this.currentPassword,
    required this.newPassword,
    required this.languageCode,
    required this.showCurrentPassword,
    required this.showConPassword,
    required this.showNewPassword,
    required this.confirmationPassword,
    required this.passwordChangeState,
  });

  factory ChangePasswordStateModel.init() {
    return const ChangePasswordStateModel(
      currentPassword: '',
      newPassword: '',
      languageCode: '',
      showCurrentPassword: true,
      showConPassword: true,
      showNewPassword: true,
      confirmationPassword: '',
      passwordChangeState: ChangePasswordStateInitial(),
    );
  }

  ChangePasswordStateModel copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmationPassword,
    String? languageCode,
    bool? showCurrentPassword,
    bool? showNewPassword,
    bool? showConPassword,
    ChangePasswordState? passwordChangeState,
  }) {
    return ChangePasswordStateModel(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      languageCode: languageCode ?? this.languageCode,
      showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
      showConPassword: showConPassword ?? this.showConPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      confirmationPassword: confirmationPassword ?? this.confirmationPassword,
      passwordChangeState: passwordChangeState ?? this.passwordChangeState,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'current_password': currentPassword});
    result.addAll({'password': newPassword});
    result.addAll({'c_password': confirmationPassword});

    return result;
  }

  ChangePasswordStateModel clear() {
    return const ChangePasswordStateModel(
      currentPassword: '',
      newPassword: '',
      languageCode: '',
      showCurrentPassword: true,
      showConPassword: true,
      showNewPassword: true,
      confirmationPassword: '',
      passwordChangeState: ChangePasswordStateInitial(),
    );
  }

  @override
  String toString() {
    return 'ChangePasswordStateModel(currentPassword: $currentPassword, password: $newPassword, passwordConfirmation: $confirmationPassword, status: $passwordChangeState)';
  }

  @override
  List<Object> get props => [
        currentPassword,
        newPassword,
        confirmationPassword,
        passwordChangeState,
        languageCode,
        showCurrentPassword,
        showConPassword,
        showNewPassword,
      ];
}

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordStateInitial extends ChangePasswordState {
  const ChangePasswordStateInitial();
}

class ChangePasswordStateLoading extends ChangePasswordState {
  const ChangePasswordStateLoading();
}

class ChangePasswordStateLoaded extends ChangePasswordState {
  final String mesage;

  const ChangePasswordStateLoaded(this.mesage);

  @override
  List<Object> get props => [mesage];
}

class ChangePasswordStateError extends ChangePasswordState {
  final String message;
  final int statusCode;

  const ChangePasswordStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class ChangePasswordFormError extends ChangePasswordState {
  final Errors errors;

  const ChangePasswordFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/auth_response/user_model.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/profile_repository.dart';
import 'profile_state_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileStateModel> {
  final ProfileRepository _repository;
  final LoginBloc _loginBloc;

  ProfileCubit({
    required ProfileRepository repository,
    required LoginBloc loginBloc,
  })  : _repository = repository,
        _loginBloc = loginBloc,
        super(const ProfileStateModel());

  UserModel? userModel;

  void imageChange(String image) {
    emit(state.copyWith(image: image, profileState: const ProfileInitial()));
  }

  void nameChange(String text) {
    debugPrint('name $text');
    emit(state.copyWith(name: text, profileState: const ProfileInitial()));
  }

  void designationChange(String text) {
    emit(state.copyWith(
        designation: text, profileState: const ProfileInitial()));
  }

  void phoneChange(String text) {
    emit(state.copyWith(phone: text, profileState: const ProfileInitial()));
  }

  void countryChange(String text) {
    print('country-change $text');
    emit(state.copyWith(country: text, profileState: const ProfileInitial()));
  }

  void stateChange(String text) {
    emit(state.copyWith(state: text, profileState: const ProfileInitial()));
  }

  void cityChange(String text) {
    emit(state.copyWith(city: text, profileState: const ProfileInitial()));
  }

  void addressChange(String text) {
    emit(state.copyWith(address: text, profileState: const ProfileInitial()));
  }

  void aboutMeChange(String text) {
    emit(state.copyWith(aboutMe: text, profileState: const ProfileInitial()));
  }

  void mySkillChange(String text) {
    emit(state.copyWith(mySkill: text, profileState: const ProfileInitial()));
  }

  void facebookChange(String text) {
    emit(state.copyWith(facebook: text, profileState: const ProfileInitial()));
  }

  void pinterestChange(String text) {
    emit(state.copyWith(pinterest: text, profileState: const ProfileInitial()));
  }

  void linkedinChange(String text) {
    emit(state.copyWith(linkedin: text, profileState: const ProfileInitial()));
  }

  void dribbbleChange(String text) {
    emit(state.copyWith(dribbble: text, profileState: const ProfileInitial()));
  }

  void twitterChange(String text) {
    emit(state.copyWith(twitter: text, profileState: const ProfileInitial()));
  }

  Future<void> getUserProfile() async {
    if (_loginBloc.userInformation != null) {
      emit(state.copyWith(langCode: _loginBloc.state.languageCode));
      emit(state.copyWith(profileState: const ProfileStateLoading()));
      final result = await _repository.getUserProfileInfo(
          _loginBloc.userInformation!.accessToken, state.langCode);
      result.fold((failure) {
        final errors = ProfileStateError(failure.message, failure.statusCode);
        emit(state.copyWith(profileState: errors));
      }, (success) {
        userModel = success;
        emit(state.copyWith(name: userModel!.name));
        emit(state.copyWith(designation: userModel!.designation));
        emit(state.copyWith(phone: userModel!.phone));
        emit(state.copyWith(address: userModel!.address));
        emit(state.copyWith(aboutMe: userModel!.aboutMe));
        emit(state.copyWith(mySkill: userModel!.mySkill));
        emit(state.copyWith(country: userModel!.country));
        emit(state.copyWith(state: userModel!.state));
        emit(state.copyWith(city: userModel!.city));
        emit(state.copyWith(facebook: userModel!.facebook));
        emit(state.copyWith(twitter: userModel!.twitter));
        emit(state.copyWith(dribbble: userModel!.dribbble));
        emit(state.copyWith(pinterest: userModel!.pinterest));
        final profileState = ProfileStateLoaded(success);
        emit(state.copyWith(profileState: profileState));
      });
    }
  }

  Future<void> updateUserInfo() async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(langCode: 'en'));
    } else {
      emit(state.copyWith(langCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(profileState: const ProfileStateUpdating()));
    final result = await _repository.updateUserInfo(
        state, _loginBloc.userInformation!.accessToken, state.langCode);
    debugPrint('update-state $state');
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = ProfileStateFormValidate(failure.errors);
        emit(state.copyWith(profileState: errors));
      } else {
        final errors =
            ProfileStateUpdateError(failure.message, failure.statusCode);
        emit(state.copyWith(profileState: errors));
      }
    }, (success) {
      final profileState = ProfileStateUpdated(success);
      emit(state.copyWith(profileState: profileState));
    });
  }
}

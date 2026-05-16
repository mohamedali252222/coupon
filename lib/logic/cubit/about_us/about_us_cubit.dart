import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/about_us/about_us_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/general_repository.dart';
import '../language_code_state.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<LanguageCodeState> {
  final GeneralRepository _generalRepository;
  final LoginBloc _loginBloc;

  AboutUsCubit({
    required GeneralRepository contactUsRepository,
    required LoginBloc loginBloc,
  })  : _generalRepository = contactUsRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState());

  AboutUsModel? aboutUs;

  Future<void> getAboutUs() async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    debugPrint('about-lang-code ${state.languageCode}');
    emit(state.copyWith(aboutUsState: AboutUsLoading()));
    final result = await _generalRepository.getAboutUs(state.languageCode);
    result.fold((failure) {
      emit(state.copyWith(
          aboutUsState: AboutUsError(failure.message, failure.statusCode)));
    }, (success) {
      aboutUs = success;
      emit(state.copyWith(aboutUsState: AboutUsLoaded(success)));
    });
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/contact_us/contact_us_model.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/general_repository.dart';
import 'contact_us_state_model.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsStateModel> {
  final GeneralRepository generalRepository;
  final LoginBloc _loginBloc;

  ContactUsCubit(
      {required GeneralRepository contactUsRepository,
      required LoginBloc loginBloc})
      : generalRepository = contactUsRepository,
        _loginBloc = loginBloc,
        super(ContactUsStateModel.init());

  ContactComponent? contactUs;

  void nameChange(String text) {
    emit(state.copyWith(name: text, contactUsState: const ContactUsInitial()));
  }

  void emailChange(String text) {
    emit(state.copyWith(email: text, contactUsState: const ContactUsInitial()));
  }

  void phoneChange(String text) {
    emit(state.copyWith(phone: text, contactUsState: const ContactUsInitial()));
  }

  void subjectChange(String text) {
    emit(state.copyWith(
        subject: text, contactUsState: const ContactUsInitial()));
  }

  void messageChange(String text) {
    emit(state.copyWith(
        message: text, contactUsState: const ContactUsInitial()));
  }

  Future<void> getContactUs() async {
    emit(state.copyWith(langCode: _loginBloc.state.languageCode));
    emit(state.copyWith(contactUsState: ContactUsLoading()));
    final result = await generalRepository.getContactUs(state.langCode);
    result.fold((failure) {
      final error = ContactUsError(failure.message, failure.statusCode);
      emit(state.copyWith(contactUsState: error));
    }, (success) {
      contactUs = success;
      emit(state.copyWith(contactUsState: ContactUsLoaded(success)));
    });
  }

  Future<void> sendContactUsMessage() async {
    emit(state.copyWith(contactUsState: ContactUsMessageLoading()));
    print('messageBody: $state');
    final result = await generalRepository.sendContactUsMessage(state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final error = ContactUsMessageFormValidate(failure.errors);
        emit(state.copyWith(contactUsState: error));
      } else {
        final error =
            ContactUsMessageError(failure.message, failure.statusCode);
        emit(state.copyWith(contactUsState: error));
      }
    }, (message) {
      emit(state.copyWith(contactUsState: ContactUsMessageLoad(message)));
      //emit(state.clear());
    });
  }

  void clear() {
    emit(state.clear());
  }
}

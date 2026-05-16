import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/details/variant/variant_model.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/upload_product_repository.dart';
import 'variant_state_model.dart';

part 'variant_state.dart';

class VariantCubit extends Cubit<VariantStateModel> {
  final UploadProductRepository _productRepository;
  final LoginBloc _loginBloc;
  List<VariantModel> variants = [];

  VariantCubit({
    required UploadProductRepository productRepository,
    required LoginBloc loginBloc,
  })  : _productRepository = productRepository,
        _loginBloc = loginBloc,
        super(const VariantStateModel());

  void changeFileName(String value) {
    emit(state.copyWith(fileName: value, variantState: const VariantInitial()));
  }

  void changeVariantName(String value) {
    emit(state.copyWith(
        variantName: value, variantState: const VariantInitial()));
  }

  void changePrice(String value) {
    emit(state.copyWith(price: value, variantState: const VariantInitial()));
  }

  Future<void> uploadVariant(String id) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(variantState: const VariantUploading()));
    log(state.toString(), name: 'variant-data');
    final result = await _productRepository.uploadVariant(
        _loginBloc.userInformation!.accessToken, id, state.languageCode, state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final formError = VariantFormError(failure.errors);
        emit(state.copyWith(variantState: formError));
      } else {
        final errors = VariantError(failure.message, failure.statusCode);
        emit(state.copyWith(variantState: errors));
      }
    }, (upload) {
      emit(state.copyWith(variantState: VariantUploaded(upload)));
    });
  }

  Future<void> updateVariant(String id) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(variantState: const VariantUploading()));
    log(state.toString(), name: 'update-variant-data');
    final result = await _productRepository.updateVariant(
        _loginBloc.userInformation!.accessToken, id, state.languageCode, state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final formError = VariantFormError(failure.errors);
        emit(state.copyWith(variantState: formError));
      } else {
        final errors = VariantError(failure.message, failure.statusCode);
        emit(state.copyWith(variantState: errors));
      }
    }, (upload) {
      emit(state.copyWith(variantState: VariantUploaded(upload)));
    });
  }

  Future<void> deleteVariant(String id) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(variantState: const VariantDeleting()));
    final result = await _productRepository.deleteVariant(
        _loginBloc.userInformation!.accessToken, id, state.languageCode);
    result.fold((failure) {
      final errors = VariantDeleteError(failure.message, failure.statusCode);
      emit(state.copyWith(variantState: errors));
      return false;
    }, (delete) {
      variants.where((v) => v.id.toString() == id);
      final v = VariantDeleted(delete);
      emit(state.copyWith(variantState: v));
      return true;
    });
  }

  void clear() {
    emit(state.clear());
  }
}

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/edit/edit_product_model.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../../state_packages_name.dart';
import 'update_state_model.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateStateModel> {
  final UploadProductRepository _productRepository;
  final LoginBloc _loginBloc;
  EditProductModel? editProduct;

  UpdateCubit({
    required UploadProductRepository productRepository,
    required LoginBloc loginBloc,
  })  : _productRepository = productRepository,
        _loginBloc = loginBloc,
        super(UpdateStateModel.init());

  void thumbImageChange(String value) {
    emit(state.copyWith(thumbImage: value, updateState: const UpdateInitial()));
  }

  void productIconChange(String value) {
    emit(state.copyWith(
      productIcon: value,
      updateState: const UpdateInitial(),
    ));
  }

  void uploadFileChange(String value) {
    emit(state.copyWith(
      uploadFile: value,
      updateState: const UpdateInitial(),
    ));
  }

  void nameChange(String value) {
    emit(state.copyWith(
      name: value,
      updateState: const UpdateInitial(),
    ));
  }

  void slugChange(String value) {
    emit(state.copyWith(
      slug: value,
      updateState: const UpdateInitial(),
    ));
  }

  void categoryChange(String value) {
    emit(state.copyWith(
      category: value,
      updateState: const UpdateInitial(),
    ));
  }

  void previewLinkChange(String value) {
    emit(state.copyWith(
      previewLink: value,
      updateState: const UpdateInitial(),
    ));
  }

  void typeChange(String value) {
    emit(state.copyWith(
      productType: value,
      updateState: const UpdateInitial(),
    ));
  }

  void regularPriceChange(String value) {
    emit(state.copyWith(
      regularPrice: value,
      updateState: const UpdateInitial(),
    ));
  }

  void extendPriceChange(String value) {
    emit(state.copyWith(
      extendPrice: value,
      updateState: const UpdateInitial(),
    ));
  }

  void descriptionChange(String value) {
    emit(state.copyWith(
      description: value,
      updateState: const UpdateInitial(),
    ));
  }

  void tagsChange(String value) {
    emit(state.copyWith(
      tags: value,
      updateState: const UpdateInitial(),
    ));
  }

  void seoTitleChange(String value) {
    emit(state.copyWith(
      seoTitle: value,
      updateState: const UpdateInitial(),
    ));
  }

  void seoDescriptionChange(String value) {
    emit(state.copyWith(
      seoDescription: value,
      updateState: const UpdateInitial(),
    ));
  }

  void highResolutionChange(String value) {
    emit(state.copyWith(
      highResolution: value,
      updateState: const UpdateInitial(),
    ));
  }

  void crossBrowserChange(String value) {
    emit(state.copyWith(
      crossBrowser: value,
      updateState: const UpdateInitial(),
    ));
  }

  void documentationChange(String value) {
    emit(state.copyWith(
      documentation: value,
      updateState: const UpdateInitial(),
    ));
  }

  void layoutChange(String value) {
    emit(state.copyWith(
      layout: value,
      updateState: const UpdateInitial(),
    ));
  }

  FutureOr<void> getEditProduct(String id) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }

    emit(state.copyWith(updateState: UpdateEditProductLoading()));
    final result = await _productRepository.getEditProductInfo(
        _loginBloc.userInformation!.accessToken, id, state.languageCode);
    result.fold((failure) {
      final error = UpdateEditProductError(failure.message, failure.statusCode);
      emit(state.copyWith(updateState: error));
    }, (success) {
      editProduct = success;
      final item = editProduct!.product;
      emit(state.copyWith(name: item.productLangFrontEnd!.name));
      emit(state.copyWith(slug: item.slug));
      emit(state.copyWith(regularPrice: item.regularPrice.toString()));
      emit(state.copyWith(extendPrice: item.extendPrice.toString()));
      emit(state.copyWith(previewLink: item.previewLink));
      emit(state.copyWith(description: item.productLangFrontEnd!.description));
      emit(state.copyWith(tags: item.productLangFrontEnd!.tags));
      emit(state.copyWith(seoTitle: item.productLangFrontEnd!.seoTitle));
      emit(state.copyWith(
          seoDescription: item.productLangFrontEnd!.seoDescription));
      emit(state.copyWith(highResolution: item.highResolution.toString()));
      emit(state.copyWith(crossBrowser: item.crossBrowser.toString()));
      emit(state.copyWith(documentation: item.documentation.toString()));
      emit(state.copyWith(layout: item.layout.toString()));
      emit(state.copyWith(productType: item.productType));
      emit(state.copyWith(category: item.categoryId.toString()));
      debugPrint('product-type ${state.productType}');
      final getTypes = UpdateEditProductLoaded(success);
      emit(state.copyWith(updateState: getTypes));
    });
  }

  Future<void> updateProduct(String id) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    debugPrint('update-state-body $state');
    emit(state.copyWith(updateState: UpdateEditProductUpdating()));
    final result = await _productRepository.updateProduct(
        _loginBloc.userInformation!.accessToken,
        id,
        state.productType,
        state.languageCode,
        state);
    result.fold((failure) {
      final error = UpdateProductError(failure.message, failure.statusCode);
      emit(state.copyWith(updateState: error));
    }, (success) {
      final edit = editProduct!.product;
      emit(state.copyWith(name: edit.productLangFrontEnd!.name));
      final getTypes = UpdateEditProductUpdated(success);
      emit(state.copyWith(updateState: getTypes));
    });
  }

  Future<Either<Failure, bool>> downloadExistingScriptFile(String id) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    final result = await _productRepository.downloadExistingScriptFile(
        _loginBloc.userInformation!.accessToken, id, state.languageCode);

    return result;
  }
}

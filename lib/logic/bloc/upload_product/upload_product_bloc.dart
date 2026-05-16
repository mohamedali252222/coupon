import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/home/product/single_product_model.dart';
import '../../../data/models/upload_product/product_type_model.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../repository/upload_product_repository.dart';
import '../login/login_bloc.dart';
import 'upload_product_state_model.dart';

part 'upload_product_event.dart';
part 'upload_product_state.dart';

class UploadProductBloc
    extends Bloc<UploadProductEvent, UploadProductStateModel> {
  final UploadProductRepository _productRepository;
  final LoginBloc _loginBloc;
  ProductTypeModel? productType;

  //EditProductModel? editProduct;
  List<SingleProductModel> product = [];

  UploadProductBloc({
    required UploadProductRepository productRepository,
    required LoginBloc loginBloc,
  })  : _productRepository = productRepository,
        _loginBloc = loginBloc,
        super(UploadProductStateModel.init()) {
    on<UploadProductThumbImageEvent>((event, emit) {
      emit(state.copyWith(
        thumbImage: event.thumbImage,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductIconEvent>((event, emit) {
      emit(state.copyWith(
        productIcon: event.productIcon,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductFileEvent>((event, emit) {
      emit(state.copyWith(
        uploadFile: event.uploadFile,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductNameEvent>((event, emit) {
      emit(state.copyWith(
        name: event.name,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductSlugEvent>((event, emit) {
      emit(state.copyWith(
        slug: event.slug,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductCategoryEvent>((event, emit) {
      emit(state.copyWith(
        category: event.category,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductPreviewLinkEvent>((event, emit) {
      emit(state.copyWith(
        previewLink: event.previewLink,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductTypeEvent>((event, emit) {
      emit(state.copyWith(
        productType: event.type,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductRegularPriceEvent>((event, emit) {
      emit(state.copyWith(
        regularPrice: event.regularPrice,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductExtendPriceEvent>((event, emit) {
      emit(state.copyWith(
        extendPrice: event.extendPrice,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductDescriptionEvent>((event, emit) {
      emit(state.copyWith(
        description: event.description,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductTagsEvent>((event, emit) {
      emit(state.copyWith(
        tags: event.tags,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductSeoTitleEvent>((event, emit) {
      emit(state.copyWith(
        seoTitle: event.seoTitle,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductSeoDescriptionEvent>((event, emit) {
      emit(state.copyWith(
        seoDescription: event.seoDescription,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductHighResolutionEvent>((event, emit) {
      emit(state.copyWith(
        highResolution: event.highResolution,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductCrossBrowserEvent>((event, emit) {
      emit(state.copyWith(
        crossBrowser: event.crossBrowser,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductDocumentationEvent>((event, emit) {
      emit(state.copyWith(
        documentation: event.documentation,
        uploadProductState: const UploadProductInitial(),
      ));
    });
    on<UploadProductLayoutEvent>((event, emit) {
      emit(state.copyWith(
        layout: event.layout,
        uploadProductState: const UploadProductInitial(),
      ));
    });

    //submitted events
    on<GetSelectProductTypeInfoEvent>(_getSelectProductTypeInfo);
    on<UploadProductSubmitEvent>(_uploadProductSubmit);
    //on<UploadProductDeleteEvent>(_deleteProduct);
    on<UploadProductClearFormEvent>(_clearUploadFormData);
  }

  Future<void> _getSelectProductTypeInfo(GetSelectProductTypeInfoEvent event,
      Emitter<UploadProductStateModel> emit) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(uploadProductState: UploadProductLoading()));
    final result = await _productRepository.getSelectProductTypeInfo(
        _loginBloc.userInformation!.accessToken, state.languageCode);
    result.fold((failure) {
      final error =
          UploadProductTypeInfoError(failure.message, failure.statusCode);
      emit(state.copyWith(uploadProductState: error));
    }, (success) {
      productType = success;
      final getTypes = UploadProductTypeInfoLoaded(success);
      emit(state.copyWith(uploadProductState: getTypes));
    });
  }

  // Future<void> _getEditProductInfo(GetEditProductInfoEvent event,
  //     Emitter<UploadProductStateModel> emit) async {
  //   emit(state.copyWith(uploadProductState: UploadProductEditLoading()));
  //   final result = await _productRepository.getEditProductInfo(
  //       _loginBloc.userInformation!.accessToken, event.id);
  //   result.fold((failure) {
  //     final error =
  //         UploadProductTypeInfoError(failure.message, failure.statusCode);
  //     emit(state.copyWith(uploadProductState: error));
  //   }, (data) {
  //     editProduct = data;
  //     final getEditProduct = UploadEditProductInfoLoaded(data);
  //     final item = data.product;
  //     //emit(state.copyWith(thumbImage: item!.thumbnailImage));
  //     //emit(state.copyWith(productIcon: item.productIcon));
  //     emit(state.copyWith(category: item!.categoryId.toString()));
  //     print('cateeeeee-id ${item.categoryId}');
  //     print('cateeeeeeiss ${item.category}');
  //     emit(state.copyWith(productType: item.productType));
  //     emit(state.copyWith(name: item.name));
  //     emit(state.copyWith(slug: item.slug));
  //     emit(state.copyWith(previewLink: item.previewLink));
  //     emit(state.copyWith(regularPrice: item.regularPrice.toStringAsFixed(0)));
  //     emit(state.copyWith(extendPrice: item.extendPrice.toStringAsFixed(0)));
  //     emit(state.copyWith(description: item.description));
  //     emit(state.copyWith(tags: item.tags));
  //     emit(state.copyWith(seoTitle: item.seoTitle));
  //     emit(state.copyWith(seoDescription: item.seoDescription));
  //     emit(state.copyWith(highResolution: item.highResolution.toString()));
  //     emit(state.copyWith(crossBrowser: item.crossBrowser.toString()));
  //     emit(state.copyWith(documentation: item.documentation.toString()));
  //     emit(state.copyWith(layout: item.layout.toString()));
  //     emit(state.copyWith(uploadProductState: getEditProduct));
  //   });
  // }

  Future<void> _uploadProductSubmit(UploadProductSubmitEvent event,
      Emitter<UploadProductStateModel> emit) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(languageCode: 'en'));
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    }
    emit(state.copyWith(uploadProductState: UploadProductLoading()));
    log(state.toString(), name: 'upload-data');
    final result = await _productRepository.uploadProduct(
        _loginBloc.userInformation!.accessToken,
        state.languageCode,
        event.type,
        state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = UploadProductFormError(failure.errors);
        emit(state.copyWith(uploadProductState: errors));
      } else {
        final error = UploadProductError(failure.message, failure.statusCode);
        emit(state.copyWith(uploadProductState: error));
      }
    }, (success) {
      final uploaded = UploadProductUploaded(success);
      emit(state.copyWith(uploadProductState: uploaded));
    });
  }

  // Future<void> _updateProductSubmit(UpdateProductSubmitEvent event,
  //     Emitter<UploadProductStateModel> emit) async {
  //   emit(state.copyWith(uploadProductState: UploadProductUpdating()));
  //   log(state.toString(), name: 'update-data');
  //   final result = await _productRepository.updateProduct(
  //       _loginBloc.userInformation!.accessToken, event.id, event.type, state);
  //   result.fold((failure) {
  //     if (failure is InvalidAuthData) {
  //       final errors = UploadProductFormError(failure.errors);
  //       emit(state.copyWith(uploadProductState: errors));
  //     } else {
  //       final error = UpdateProductError(failure.message, failure.statusCode);
  //       emit(state.copyWith(uploadProductState: error));
  //     }
  //   }, (success) {
  //     final uploaded = UploadProductUpdated(success);
  //     emit(state.copyWith(uploadProductState: uploaded));
  //   });
  // }

  _clearUploadFormData(UploadProductClearFormEvent event,
      Emitter<UploadProductStateModel> emit) {
    emit(state.clear());
  }

// Future<void> _deleteProduct(UploadProductDeleteEvent event,
//     Emitter<UploadProductStateModel> emit) async {
//   emit(state.copyWith(uploadProductState: UploadProductLoading()));
//   final result = await _productRepository.deleteProduct(
//       _loginBloc.userInformation!.accessToken, event.id);
//   result.fold((failure) {
//     final error = UploadProductError(failure.message, failure.statusCode);
//     emit(state.copyWith(uploadProductState: error));
//     return false;
//   }, (delete) {
//     product.where((productId) => productId.id.toString() == event.id);
//     final uploaded = UploadProductUploaded(delete);
//     emit(state.copyWith(uploadProductState: uploaded));
//     return true;
//   });
// }
}

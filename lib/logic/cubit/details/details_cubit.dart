import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/details/product_details_model.dart';
import '../../../data/models/details/variant/variant_model.dart';
import '../../../presentation/errors/errors_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/details_repository.dart';
import '../language_code_state.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<LanguageCodeState> {
  final DetailsRepository _detailsRepository;
  final LoginBloc _loginBloc;

  DetailsCubit(
      {required DetailsRepository detailsRepository,
      required LoginBloc loginBloc})
      : _detailsRepository = detailsRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState());
  final messageController = TextEditingController();
  final commentController = TextEditingController();
  ProductDetailsModel? details;
  VariantModel? selectedVariant;
  String priceType = "";

  Future<void> getProductDetails(String slug) async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    emit(state.copyWith(detailsState: DetailsLoading()));
    final result =
        await _detailsRepository.getProductDetails(slug, state.languageCode);
    result.fold((failure) {
      final error = DetailsError(failure.message, failure.statusCode);
      emit(state.copyWith(detailsState: error));
    }, (success) {
      details = success;
      if (details!.product!.productType != 'script') {
        selectedVariant = details!.firstVariant;
      } else {
        priceType = "regular_price";
      }
      emit(state.copyWith(detailsState: DetailsLoaded(success)));
    });
  }

  Future<void> sendMessageToAuthor(Map<String, dynamic> body) async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    emit(state.copyWith(detailsState: DetailsSendMessageLoading()));
    print('message-body $body');
    final result = await _detailsRepository.sendMessageToAuthor(
        _loginBloc.userInformation!.accessToken, body, state.languageCode);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        emit(state.copyWith(detailsState: DetailsFormError(failure.errors)));
      } else {
        emit(state.copyWith(
            detailsState:
                PostCommentError(failure.message, failure.statusCode)));
      }
    }, (success) {
      emit(state.copyWith(detailsState: DetailsSendMessageLoaded(success)));
    });
  }

  Future<void> postComment(Map<String, dynamic> body) async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    emit(state.copyWith(detailsState: PostCommentLoading()));
    print('comment-body $body');
    final result = await _detailsRepository.postComment(
        _loginBloc.userInformation!.accessToken, body, state.languageCode);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        emit(state.copyWith(detailsState: DetailsFormError(failure.errors)));
      } else {
        emit(state.copyWith(
            detailsState:
                PostCommentError(failure.message, failure.statusCode)));
      }
    }, (success) {
      emit(state.copyWith(detailsState: DetailsSendMessageLoaded(success)));
    });
  }

  Future<void> postReview(Map<String, dynamic> body) async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    emit(state.copyWith(detailsState: PostReviewLoading()));
    print('review-body $body');
    final result = await _detailsRepository.postReview(
        _loginBloc.userInformation!.accessToken, body, state.languageCode);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        emit(state.copyWith(detailsState: DetailsFormError(failure.errors)));
      } else {
        emit(state.copyWith(
            detailsState: DetailsError(failure.message, failure.statusCode)));
      }
    }, (success) {
      emit(state.copyWith(detailsState: DetailsSendMessageLoaded(success)));
    });
  }
}

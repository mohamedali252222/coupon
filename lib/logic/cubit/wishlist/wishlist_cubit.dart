import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/wishlist/wishlist_model.dart';
import '../../../presentation/errors/failure.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/wishlist_repository.dart';
import '../language_code_state.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<LanguageCodeState> {
  WishlistCubit({
    required WishListRepository wishlistRepository,
    required LoginBloc loginBloc,
  })  : _wishlistRepository = wishlistRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState());

  final WishListRepository _wishlistRepository;
  final LoginBloc _loginBloc;
  List<WishlistModel> wishList = [];

  Future<void> addToWish(String id) async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    //emit(state.copyWith(wishlistState: WishlistLoading()));
    final result = await _wishlistRepository.addToWish(
        id, _loginBloc.userInformation!.accessToken, state.languageCode);
    result.fold((failure) {
      final errors = WishlistError(failure.message, failure.statusCode);
      emit(state.copyWith(wishlistState: errors));
    }, (success) {
      getWistItems();
      final st = WishListStateSuccess(success);
      emit(state.copyWith(wishlistState: st));
    });
  }

  Future<Either<Failure, String>> deleteWishItem(String id) async {
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    //emit(state.copyWith(wishlistState: WishlistLoading()));
    final result = await _wishlistRepository.deleteWishItem(
        id, _loginBloc.userInformation!.accessToken, state.languageCode);
    result.fold((failure) {
      final errors = WishlistError(failure.message, failure.statusCode);
      emit(state.copyWith(wishlistState: errors));
    }, (success) {
      getWistItems();
      wishList.removeWhere((element) => element.id.toString() == id);
      final st = WishListStateSuccess(success);
      emit(state.copyWith(wishlistState: st));
    });
    return result;
  }

  Future<void> getWistItems() async {
    print('getWistItems');
    emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
    emit(state.copyWith(wishlistState: WishlistLoading()));
    final result = await _wishlistRepository.getWishItemList(
        _loginBloc.userInformation!.accessToken, state.languageCode);
    result.fold((failure) {
      final errors = WishlistShowError(failure.message, failure.statusCode);
      emit(state.copyWith(wishlistState: errors));
    }, (success) {
      wishList = success;
      print('wishItems ${wishList.length}');
      final st = WishlistLoaded(wishListData: success);
      emit(state.copyWith(wishlistState: st));
    });
  }
}

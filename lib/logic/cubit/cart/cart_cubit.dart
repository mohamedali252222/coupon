import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/cart/cart_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/cart_repository.dart';
import '../language_code_state.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<LanguageCodeState> {
  final CartRepository _cartRepository;
  final LoginBloc _loginBloc;
  CartModel? cartModel;
  List<CartItemModel> cartList = [];

  CartCubit({
    required CartRepository cartRepository,
    required LoginBloc loginBloc,
  })  : _cartRepository = cartRepository,
        _loginBloc = loginBloc,
        super(const LanguageCodeState());

  bool isAlreadyInCart(int id) {
    for (var e in cartModel!.cartItems!) {
      if (e.product!.id == id) {
        return true;
      }
    }
    return false;
  }

  Future<void> getCartProduct() async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(
          cartState: const CartError('Please login first', 401)));
      return;
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
      emit(state.copyWith(cartState: CartLoading()));
      final result = await _cartRepository.getCartProduct(
          _loginBloc.userInformation!.accessToken, state.languageCode);
      result.fold(
        (failure) {
          final error = CartError(failure.message, failure.statusCode);
          emit(state.copyWith(cartState: error));
        },
        (success) {
          cartModel = success;
          final successState = CartLoaded(success);
          emit(state.copyWith(cartState: successState));
        },
      );
    }
  }

  Future<void> removeCartItem(String id) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(
          cartState: const CartError('Please login first', 401)));
      return;
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
      emit(state.copyWith(cartState: CartItemRemoving()));
      final result = await _cartRepository.removeCartItem(
          id, _loginBloc.userInformation!.accessToken, state.languageCode);
      result.fold((failure) {
        final errors = CartRemoveError(failure.message, failure.statusCode);
        emit(state.copyWith(cartState: errors));
        return false;
      }, (removed) {
        //getCartProduct();
        cartList.removeWhere((element) => element.id.toString() == id);
        final success = CartRemoved(removed);
        emit(state.copyWith(cartState: success));
        return true;
      });
    }
  }
}

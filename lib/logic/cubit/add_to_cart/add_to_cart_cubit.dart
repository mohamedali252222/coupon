import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/cart/add_to_cart_model.dart';
import '../../../data/models/cart/coupon_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/cart_repository.dart';
import '../language_code_state.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<LanguageCodeState> {
  AddToCartCubit({
    required LoginBloc loginBloc,
    required CartRepository cartRepository,
  })  : _loginBloc = loginBloc,
        _cartRepository = cartRepository,
        super(const LanguageCodeState()) {
    countTotalCart();
    fetchCouponInfo();
  }

  final LoginBloc _loginBloc;
  final CartRepository _cartRepository;
  int _total = 0;

  int? get totalCart => _total;

  set total(int tot) => _total = tot;

  CouponDto? _couponData;

  CouponDto? get couponDto => _couponData;

  set coupon(CouponDto cpnData) => _couponData = cpnData;

  Future<void> addToCart(AddToCartModel dataModel) async {
    if (_loginBloc.userInformation == null) {
      emit(state.copyWith(
          addToCartState:
              const AddToCartStateError("Please login first", 401)));
      return;
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
      emit(state.copyWith(addToCartState: const AddToCartStateLoading()));

      debugPrint("check cart: ${dataModel.toMap()}");

      final result = await _cartRepository.addToCart(
          _loginBloc.userInformation!.accessToken,
          dataModel,
          state.languageCode);
      result.fold(
        (failure) {
          final errors =
              AddToCartStateError(failure.message, failure.statusCode);
          emit(state.copyWith(addToCartState: errors));
        },
        (successData) {
          countTotalCart();
          final success = AddToCartStateAdded(successData);
          emit(state.copyWith(addToCartState: success));
        },
      );
    }
  }

  Future<void> applyCoupon(Map<String, String> couponName) async {
    if (_loginBloc.userInformation == null) {
      const errors = ApplyStateError("Please login first", 401);
      emit(state.copyWith(addToCartState: errors));
      return;
    } else {
      emit(state.copyWith(languageCode: _loginBloc.state.languageCode));
      emit(state.copyWith(addToCartState: const ApplyStateLoading()));

      final result = await _cartRepository.applyCoupon(couponName,
          _loginBloc.userInformation!.accessToken, state.languageCode);

      result.fold(
        (failure) {
          final errors = ApplyStateError(failure.message, failure.statusCode);
          emit(state.copyWith(addToCartState: errors));
        },
        (successData) {
          coupon = successData;
          emit(state.copyWith(addToCartState: CouponDataLoaded(successData)));
        },
      );
    }
  }

  void removeCoupon() {
    final result = _cartRepository.removeCoupon();
    result.fold((l) {
      _couponData = null;
      print('coupon-removed from l');
    }, (r) {
      _couponData = null;
      print('coupon-removed from r');
    });
  }

  Future<void> fetchCouponInfo() async {
    final result = _cartRepository.fetchCouponData();
    result.fold((l) {
      _couponData = null;
    }, (r) {
      coupon = r;
    });
  }

  countTotalCart() async {
    if (_loginBloc.userInformation!.accessToken.isNotEmpty) {
      final result0 = await _cartRepository
          .cartQty(_loginBloc.userInformation!.accessToken);

      result0.fold((l) {
        print("failed total : $_total");
        emit(state.copyWith(addToCartState: TotalCartItem(_total)));
      }, (r) {
        print("succes total : $r");
        _total = r;
        emit(state.copyWith(addToCartState: TotalCartItem(r)));
      });
    }
  }
}

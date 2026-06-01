import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../data/data_provider/remote_data_source.dart';
import '../../../data/models/offer_coupon/offer_coupon_model.dart';
import '../../bloc/login/login_bloc.dart';

part 'offer_coupons_state.dart';

class OfferCouponsCubit extends Cubit<OfferCouponsState> {
  final RemoteDataSource remoteDataSource;
  final LoginBloc loginBloc;

  OfferCouponsCubit({required this.remoteDataSource, required this.loginBloc})
      : super(const OfferCouponsState());

  Future<void> fetchOfferCoupons(String langCode) async {
    emit(state.copyWith(loading: true, error: null));

    // Check if user is logged in
    final token = loginBloc.userInformation?.accessToken;
    debugPrint('offer-coupons: userInformation is null: ${loginBloc.userInformation == null}');
    debugPrint('offer-coupons: token is null: ${token == null}');
    debugPrint('offer-coupons: token is empty: ${token?.isEmpty ?? true}');
    if (loginBloc.userInformation == null || 
        loginBloc.userInformation!.accessToken == null ||
        loginBloc.userInformation!.accessToken!.isEmpty) {
      emit(state.copyWith(
        loading: false,
        error: 'يجب تسجيل الدخول لعرض الكوبونات',
      ));
      return;
    }

    try {
      final res = await remoteDataSource.getOfferCoupons(
        loginBloc.userInformation!.accessToken,
        langCode,
      );
      final data = (res['offer_coupons']['data'] as List? ?? []);

      final list = data
          .map((e) => OfferCouponModel.fromMap(e as Map<String, dynamic>))
          .toList();

      emit(state.copyWith(loading: false, coupons: list));
    } catch (e) {
      debugPrint('offer-coupons error: $e');
      emit(state.copyWith(
        loading: false,
        error: e.toString(),
      ));
    }
  }
}
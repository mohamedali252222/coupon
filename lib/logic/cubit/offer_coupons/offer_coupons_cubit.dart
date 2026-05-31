import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/data_provider/remote_data_source.dart';
import '../../../data/models/offer_coupon/offer_coupon_model.dart';

part 'offer_coupons_state.dart';

class OfferCouponsCubit extends Cubit<OfferCouponsState> {
  final RemoteDataSource remoteDataSource;

  OfferCouponsCubit({required this.remoteDataSource})
      : super(const OfferCouponsState());

  Future<void> fetchOfferCoupons(String langCode) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final res = await remoteDataSource.getOfferCoupons(langCode);
      final data = (res['offer_coupons']['data'] as List? ?? []);

      final list = data
          .map((e) => OfferCouponModel.fromMap(e as Map<String, dynamic>))
          .toList();

      emit(state.copyWith(loading: false, coupons: list));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: e.toString(),
      ));
    }
  }
}
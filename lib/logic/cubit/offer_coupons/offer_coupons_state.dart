part of 'offer_coupons_cubit.dart';

class OfferCouponsState extends Equatable {
  final bool loading;
  final List<OfferCouponModel> coupons;
  final String? error;

  const OfferCouponsState({
    this.loading = false,
    this.coupons = const [],
    this.error,
  });

  OfferCouponsState copyWith({
    bool? loading,
    List<OfferCouponModel>? coupons,
    String? error,
  }) {
    return OfferCouponsState(
      loading: loading ?? this.loading,
      coupons: coupons ?? this.coupons,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, coupons, error];
}
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../bloc/search/search_bloc.dart';
import 'about_us/about_us_cubit.dart';
import 'add_to_cart/add_to_cart_cubit.dart';
import 'cart/cart_cubit.dart';
import 'dashboard/dashboard_cubit.dart';
import 'details/details_cubit.dart';
import 'download/download_cubit.dart';
import 'home/home_cubit.dart';
import 'payment/payment_cubit.dart';
import 'privacy_policy/privacy_policy_cubit.dart';
import 'wishlist/wishlist_cubit.dart';
import 'withdraw/seller_withdraw/seller_withdraw_cubit.dart';
import 'withdraw/single_account_info/single_account_info_cubit.dart';

class LanguageCodeState extends Equatable {
  final String languageCode;
  final PrivacyPolicyState privacyPolicyState;
  final HomeState homeState;
  final AboutUsState aboutUsState;
  final WishlistState wishlistState;
  final DetailsState detailsState;
  final AddToCartState addToCartState;
  final CartState cartState;
  final PaymentState paymentState;
  final SearchState searchState;
  final DashboardState dashboardState;
  final SingleAccountInfoState accountInfoState;
  final SellerWithdrawState sellerWithdrawState;
  final DownloadState downloadState;

  const LanguageCodeState({
    this.languageCode = '',
    this.privacyPolicyState = const PrivacyPolicyInitial(),
    this.homeState = const HomeInitial(),
    this.aboutUsState = const AboutUsInitial(),
    this.wishlistState = const WishlistInitial(),
    this.detailsState = const DetailsInitial(),
    this.addToCartState = const AddToCartStateInitial(),
    this.cartState = const CartInitial(),
    this.paymentState = const PaymentInitial(),
    this.searchState = const SearchInitial(),
    this.dashboardState = const DashboardInitial(),
    this.accountInfoState = const SingleAccountInfoInitial(),
    this.sellerWithdrawState = const SellerWithdrawInitial(),
    this.downloadState = const DownloadInitial(),
  });

  LanguageCodeState copyWith({
    String? languageCode,
    PrivacyPolicyState? privacyPolicyState,
    HomeState? homeState,
    AboutUsState? aboutUsState,
    WishlistState? wishlistState,
    DetailsState? detailsState,
    AddToCartState? addToCartState,
    CartState? cartState,
    PaymentState? paymentState,
    SearchState? searchState,
    DashboardState? dashboardState,
    SingleAccountInfoState? accountInfoState,
    SellerWithdrawState? sellerWithdrawState,
    DownloadState? downloadState,
  }) {
    return LanguageCodeState(
      languageCode: languageCode ?? this.languageCode,
      homeState: homeState ?? this.homeState,
      privacyPolicyState: privacyPolicyState ?? this.privacyPolicyState,
      aboutUsState: aboutUsState ?? this.aboutUsState,
      wishlistState: wishlistState ?? this.wishlistState,
      detailsState: detailsState ?? this.detailsState,
      addToCartState: addToCartState ?? this.addToCartState,
      cartState: cartState ?? this.cartState,
      paymentState: paymentState ?? this.paymentState,
      searchState: searchState ?? this.searchState,
      dashboardState: dashboardState ?? this.dashboardState,
      accountInfoState: accountInfoState ?? this.accountInfoState,
      sellerWithdrawState: sellerWithdrawState ?? this.sellerWithdrawState,
      downloadState: downloadState ?? this.downloadState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lang_code': languageCode,
    };
  }

  factory LanguageCodeState.fromMap(Map<String, dynamic> map) {
    return LanguageCodeState(
      languageCode: map['lang_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageCodeState.fromJson(String source) =>
      LanguageCodeState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        languageCode,
        privacyPolicyState,
        homeState,
        aboutUsState,
        wishlistState,
        detailsState,
        addToCartState,
        cartState,
        paymentState,
        searchState,
        dashboardState,
        accountInfoState,
        sellerWithdrawState,
        downloadState,
      ];
}

import 'package:flutter/material.dart';

import '../../data/models/auth_response/user_model.dart';
import '../../data/models/details/comment/single_comment_model.dart';
import '../../data/models/download/download_model.dart';
import '../../data/models/edit/edit_product_model.dart';
import '../screens/filter/filter_screen.dart';
import '../screens/home/component/special_offer_screen.dart';
import '../screens/payment/bank_payment_screen.dart';
import '../screens/payment/flutter_wave_payment_screen.dart';
import '../screens/payment/instamojo_payment_screen.dart';
import '../screens/payment/molli_payment_screen.dart';
import '../screens/payment/paypal_payment_screen.dart';
import '../screens/payment/paystack_payment_screen.dart';
import '../screens/payment/razorpay_payment_screen.dart';
import '../screens/payment/ssl_payment_screen.dart';
import '../screens/payment/stripe_payment_screen.dart';
import '../screens/review/review_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/setting/privacy_policy_screen.dart';
import '../screens/setting/terms_and_condition_screen.dart';
import '../screens/update/update_product.dart';
import '../screens/variant/variant_screen.dart';
import 'packages_name.dart';

class RouteNames {
  static const String splashScreen = '/splashScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String authenticationScreen = '/authenticationScreen';

  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String verificationCodeScreen = '/verificationCodeScreen';
  static const String updatePasswordScreen = '/updatePasswordScreen';

  static const String mainScreen = '/mainScreen';

  static const String wishlistScreen = '/wishlistScreen';
  static const String searchScreen = '/searchScreen';
  static const String filterScreen = '/filterScreen';
  static const String downloadedFileScreen = '/downloadedFileScreen';
  static const String overviewScreen = '/overviewScreen';
  static const String updateProfileScreen = '/updateProfileScreen';
  static const String portfolioScreen = '/portfolioScreen';
  static const String withdrawScreen = '/withdrawScreen';
  static const String uploadProductTypeScreen = '/uploadProductTypeScreen';
  static const String uploadScreen = '/uploadScreen';
  static const String updateProduct = '/updateProduct';

  static const String changePasswordScreen = '/changePasswordScreen';
  static const String termsAndConditionScreen = '/termsAndConditionScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String faqScreen = '/faqScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String contactUsScreen = '/contactUsScreen';

  static const String allCategoryScreen = '/allCategoryScreen';

  static const String trendingScreen = '/trendingScreen';
  static const String detailScreen = '/detailScreen';
  static const String moreCommentScreen = '/moreCommentScreen';
  static const String moreReviewScreen = '/moreReviewScreen';

  static const String bestSellingThemeScreen = 'bestSellingThemeScreen';

  static const String cartScreen = '/cartScreen';
  static const String specialOfferScreen = '/specialOfferScreen';

  static const String variantScreen = '/variantScreen';

  static const String reviewScreen = '/reviewScreen';

  // static const String profileScreen = '/profileScreen';
  // static const String showProfileScreen = '/showProfileScreen';
  // static const String mainScreen = '/mainScreen';
  // static const String notificationOneScreen = '/notificationOneScreen';
  static const String paymentScreen = '/paymentScreen';
  static const String bankPaymentScreen = '/bankPaymentScreen';
  static const String stripePaymentScreen = '/stripePaymentScreen';
  static const String flutterWavePaymentScreen = '/flutterWavePaymentScreen';
  static const String payStackPaymentScreen = '/payStackPaymentScreen';
  static const String molliPaymentScreen = '/molliPaymentScreen';
  static const String sslPaymentScreen = '/sslPaymentScreen';
  static const String instamojoPaymentScreen = '/instamojoPaymentScreen';
  static const String razorpayPaymentScreen = '/razorpayPaymentScreen';
  static const String paypalPaymentScreen = '/paypalPaymentScreen';

  // static const String settingScreen = '/settingScreen';

  // static const String appInfoScreen = '/appInfoScreen';
  // static const String logoutScreen = '/logoutScreen';
  // static const String addPaymentMethodScreen = '/addPaymentMethodScreen';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());
      case RouteNames.onBoardingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnBoardingScreen());
      case RouteNames.authenticationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AuthenticationScreen());

      case RouteNames.forgotPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotPasswordScreen());
      case RouteNames.verificationCodeScreen:
        final isNewUser = settings.arguments as bool;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => VerificationCodeScreen(isNewUser: isNewUser));
      case RouteNames.updatePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const UpdatePasswordScreen());

      case RouteNames.mainScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MainScreen());

      case RouteNames.overviewScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OverViewScreen());

      case RouteNames.updateProfileScreen:
        final userModel = settings.arguments as UserModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => UpdateProfileScreen(userModel: userModel));
      case RouteNames.portfolioScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PortfolioScreen());
      case RouteNames.downloadedFileScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const DownloadedFileScreen());
      case RouteNames.withdrawScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WithdrawScreen());

      case RouteNames.uploadProductTypeScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const UploadProductTypeScreen());

      case RouteNames.uploadScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const UploadScreen());

      case RouteNames.updateProduct:
        final id = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => UpdateProduct(id: id));

      case RouteNames.changePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChangePasswordScreen());
      case RouteNames.termsAndConditionScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const TermsAndConditionScreen());
      case RouteNames.privacyPolicyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PrivacyPolicyScreen());
      case RouteNames.faqScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const FaqScreen());
      case RouteNames.aboutUsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AboutUsScreen());
      case RouteNames.contactUsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactUsScreen());

      case RouteNames.wishlistScreen:
        final bool isVisibleBackButton = settings.arguments as bool;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                WishlistScreen(isVisibleBackButton: isVisibleBackButton));

      case RouteNames.searchScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SearchScreen());
      case RouteNames.filterScreen:
        final keyword = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => FilterScreen(keyword: keyword));
      case RouteNames.allCategoryScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AllCategoryScreen());

      case RouteNames.bestSellingThemeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BestSellingThemeScreen());

      case RouteNames.trendingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const TrendingScreen());
      case RouteNames.detailScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => DetailScreen(slug: slug));
      case RouteNames.moreCommentScreen:
        final comments = settings.arguments as List<SingleCommentModel>;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => MoreCommentScreen(data: comments));

      case RouteNames.moreReviewScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MoreReviewScreen());
      //   case RouteNames.popularSellScreen:
      //     return MaterialPageRoute(
      //         settings: settings, builder: (_) => const PopularSellScreen());
      //
      case RouteNames.cartScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CartScreen());
      case RouteNames.variantScreen:
        final editProduct = settings.arguments as EditProductModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => VariantScreen(editProduct: editProduct));

      case RouteNames.specialOfferScreen:
        final url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => SpecialOfferScreen(url: url));
      //   case RouteNames.checkoutScreen:
      //     return MaterialPageRoute(
      //         settings: settings, builder: (_) => const CheckOutScreen());
      case RouteNames.reviewScreen:
        final theme = settings.arguments as DownloadItem;
        return MaterialPageRoute(
            settings: settings, builder: (_) => ReviewScreen(file: theme));
      //   case RouteNames.profileScreen:
      //     return MaterialPageRoute(
      //         settings: settings, builder: (_) => const ProfileScreen());
      //   case RouteNames.mainScreen:
      //     return MaterialPageRoute(
      //         settings: settings, builder: (_) => const MainScreen());
      //   case RouteNames.notificationOneScreen:
      //     return MaterialPageRoute(
      //         settings: settings, builder: (_) => const NotificationOne());
      //   case RouteNames.showProfileScreen:
      //     return MaterialPageRoute(
      //         settings: settings, builder: (_) => const ShowProfile());
      case RouteNames.paymentScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PaymentScreen());
      case RouteNames.bankPaymentScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const BankPaymentScreen());

      case RouteNames.stripePaymentScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const StripePaymentScreen());
      case RouteNames.flutterWavePaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => FlutterWaveScreen(url: url));

      case RouteNames.molliPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => MolliPaymentScreen(url: url));
      case RouteNames.sslPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => SSlPaymentScreen(url: url));

      case RouteNames.instamojoPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => InstamojoPaymentScreen(url: url));

      case RouteNames.razorpayPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => RazorpayPaymentScreen(url: url));

      case RouteNames.paypalPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => PaypalPaymentScreen(url: url));

      case RouteNames.payStackPaymentScreen:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => PayStackPaymentScreen(url: url));

      //   case RouteNames.settingScreen:
      //     return MaterialPageRoute(
      //         settings: settings, builder: (_) => const SettingScreen());
      //   case RouteNames.termsAndConScreen:

      //   case RouteNames.appInfoScreen:
      //     return MaterialPageRoute(
      //         settings: settings, builder: (_) => const AppInfoScreen());
      //   case RouteNames.logoutScreen:
      //     return MaterialPageRoute(
      //         settings: settings, builder: (_) => const LogOutScreen());
      //   case RouteNames.addPaymentMethodScreen:
      //     return MaterialPageRoute(
      //         settings: settings, builder: (_) => const NotificationTwo());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route Found ${settings.name}'),
            ),
          ),
        );
    }
  }
}

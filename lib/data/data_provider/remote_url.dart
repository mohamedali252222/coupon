import '../../logic/cubit/setting/website_setup_cubit.dart';

class RemoteUrls {
  //static const String rootUrl = "https://alasmart.quomodosoft.online/";
  static const String rootUrl = "https://ecommerce.pixell.site/";

  //static const String rootUrl = "https://alasmart.minionionbd.com/";

  static const String baseUrl = '${rootUrl}api/';

  static const String homeUrl = baseUrl;

  static const String userLogin = '${baseUrl}store-login';

  static const String userRegistration = '${baseUrl}store-register';
  static const String newUserVerification = '${baseUrl}user-verification';
  static const String resendVerificationCode = '${baseUrl}resend-register';

  static String logout = '${baseUrl}user-logout';
  static const String forgotPassWord = '${baseUrl}send-forget-password';
  static String updatePassword = '${baseUrl}store-reset-password';

  static const String websiteSetup = '${baseUrl}website-setup';
  static const String getCategoryList = '${baseUrl}all-categories';
  static const String getBestSellingProduct = '${baseUrl}best-sell-products';

  static String getProductDetails(String slug) => '${baseUrl}product/$slug';

  static String sendMessageToAuthor = '${baseUrl}contact-with-author';

  static String postComment = '${baseUrl}product-comment';

  static String postReview = '${baseUrl}product-review';

  //cart related routes start
  static String getCartProduct = '${baseUrl}cart-item';

  static String addToCartUrl = '${baseUrl}add-to-cart';

  static String downloadUrls = '${baseUrl}download';

  static String downloadFileUrl(String id) => '${baseUrl}download-script/$id';

  static String removeCartUrl(String id) => '${baseUrl}cart-remove/$id';

  static String miniCartUrl(String token) => '${baseUrl}mini-cart?token=$token';

  static String addToWishUrl(String id) => '${baseUrl}add/wishlist/$id';

  //cart related routes end

  static String countryListUrl(String token) =>
      '${baseUrl}user/address/create?token=$token';

  static String stateByCountryId(String countryId) =>
      '${baseUrl}state-by-country/$countryId';

  static String citiesByStateId(String stateId) =>
      '${baseUrl}city-by-state/$stateId';

  static String myProfileUrl(String token, String langCode) =>
      '${baseUrl}my-profile?token=$token&lang_code=$langCode';

  static String updateUserInfoUrl = '${baseUrl}user-update-profile';

  static String changePasswordUrl = '${baseUrl}update-password';

  static String wishlistUrl = '${baseUrl}wishlist';

  static String wishItemDeleteUrl(String id) => '${baseUrl}delete/wishlist/$id';

  static String checkOutUrl(String token) => '${baseUrl}checkout?token=$token';

  static String couponInfoUrl = '${baseUrl}coupon-apply';

  static String couponRemoveUrl = '${baseUrl}coupon-remove';

  /*<----- MISCELLENIOUS API-------> */

  static String getAboutUs = '${baseUrl}about-us';

  static String getPrivacyPolicy = '${baseUrl}privacy-policy';

  static String getFaqContent = '${baseUrl}faq';

  static String getTermsAndCondition = '${baseUrl}terms-and-conditions';

  static String getContactUs = '${baseUrl}contact-us';

  static String sendContactUsMessage = '${baseUrl}send-contact-message';

  // static String createPropertyInfoUrl(String token, String purpose) =>
  //     '${baseUrl}user/property/create?token=$token&purpose=$purpose';
  //
  // static String editInfoUrl(String id, String token) =>
  //     '${baseUrl}user/property/$id/edit?token=$token';
  //
  // static String getPropertyChooseInfo(String token) =>
  //     '${baseUrl}user/choose-property-type?token=$token';
  //
  // static String changePassword(String token) =>
  //     '${baseUrl}user/update-password?token=$token';
  //

  //cart upload related routes start
  static String getSelectProductTypeInfo = '${baseUrl}select-product-type';

  static String getUserPortfolio = '${baseUrl}portfolio';

  static String uploadProduct(String type) => type == 'script'
      ? '${baseUrl}product-store'
      : '${baseUrl}store-image-type-product';

  static String updateProduct(String id, String type) => type == 'script'
      ? '${baseUrl}product-update/$id'
      : '${baseUrl}image-product-update/$id';

  static String uploadVariant(String id) =>
      '${baseUrl}store-product-variant/$id';

  static String updateVariant(String id) =>
      '${baseUrl}update-product-variant/$id';

  static String deleteProduct(String id) => '${baseUrl}delete-product/$id';

  static String deleteVariant(String id) =>
      '${baseUrl}delete-product-variant/$id';

  static String getEditProductInfo(String id) => '${baseUrl}product-edit/$id';

  static String downloadExistingScriptFile(String token, String file) =>
      '${baseUrl}download-existing-file/$file?token=$token';

  //cart upload related routes end

  //payment urls start
  static String getPaymentPageInformation = '${baseUrl}payment-info';

  static String bankPayment = '${baseUrl}bank-payment';

  static String stripePayment(String token) =>
      '${baseUrl}pay-with-stripe?token=$token';

  static String payWithFlutterWave(String token) =>
      '${rootUrl}payment-api/flutterwave-webview?token=$token';

  static String payWithPayStack(String token) =>
      '${rootUrl}payment-api/paystack-webview?token=$token';

  static String payWithMolli(String token) =>
      '${rootUrl}payment-api/mollie-webview?token=$token';

  static String payWithInstamojo(String token) =>
      '${rootUrl}payment-api/instamojo-webview?token=$token';

  static String payWithRazorpay(String token) =>
      '${rootUrl}payment-api/razorpay-webview?token=$token';

  static String payWithPaypal(String token) =>
      '${rootUrl}payment-api/paypal-webview?token=$token';

  static String payWithSSl(String token) =>
      '${rootUrl}payment-api/pay?token=$token';

/*<----- WITHDRAW API-------> */

  static String getSellerWithdrawInfo = "${baseUrl}withdraw";

  static String getWithdrawAccountInfo(String id) =>
      "${baseUrl}get-withdraw-account-info/$id";

  static String createWithdraw = "${baseUrl}withdraw-store";

  static String getSearchProperty = '${baseUrl}products?';
  static String getCategoryByName = '${baseUrl}products?';
  static String getAllPropertyList = '${baseUrl}products';

  // Dynamic `file` URL based on `WebsiteSetupCubit.setting`
  // static imgUrl(WebsiteSetupCubit cubit) {
  //   final fileUrl = cubit.setting!.fileBaseUrl;
  //   return fileUrl;
  // }
  //
  // static String? get fileUrl => WebsiteSetupCubit.fileBaseUrl;
  //
  // static imageUrl(String imageUrl) {
  //   final fileUrl = WebsiteSetupCubit.fileBaseUrl;
  //   String? formattedFileUrl = fileUrl!.endsWith('/') ? fileUrl : '$fileUrl/';
  //   return formattedFileUrl + imageUrl;
  // }

static const String fileUrl = "https://alasmart.mamunuiux.com/";
static imageUrl(String imageUrl) => fileUrl + imageUrl;
}

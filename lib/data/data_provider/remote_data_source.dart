import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../logic/bloc/login/login_state_model.dart';
import '../../logic/bloc/signup/sign_up_state_model.dart';
import '../../logic/bloc/upload_product/upload_product_state_model.dart';
import '../../logic/cubit/change_password/change_password_cubit.dart';
import '../../logic/cubit/contact_us/contact_us_state_model.dart';
import '../../logic/cubit/forgot_password/forgot_password_state_model.dart';
import '../../logic/cubit/profile/profile_state_model.dart';
import '../../logic/cubit/stripe_payment/stripe_payment_state_model.dart';
import '../../logic/cubit/update/update_state_model.dart';
import '../../logic/cubit/variant/variant_state_model.dart';
import '../../logic/cubit/withdraw/create_withdraw/create_withdraw_state_model.dart';
import '../models/cart/add_to_cart_model.dart';
import 'network_parser.dart';
import 'remote_url.dart';

abstract class RemoteDataSource {
  Future login(LoginStateModel body);

  Future<String> userRegistration(SignUpStateModel body);

  Future<String> newUserVerification(SignUpStateModel body);

  Future<String> resendVerificationCode(Map<String, dynamic> body);

  Future<String> logout(Uri uri);

  Future<String> forgotPassword(Map<String, dynamic> body);

  Future<String> updatePassword(PasswordStateModel body);

  Future getWebsiteSetupData();

  Future getHomeData(String langCode);

  Future getUserProfileInfo(String token, String langCode);

  Future getWishItemList(String token, String langCode);

  Future<String> addToWish(String id, String token, String langCode);

  Future<String> deleteWishListItem(String id, String token, String langCode);

  Future<String> updateUserInfo(
      ProfileStateModel body, String token, String langCode);

  Future<String> passwordChange(
      ChangePasswordStateModel changePassData, String token, String langCode);

//   Future statesByCountryId(String countryID);
//
//   Future<List<CountryModel>> getCountryList(String token);
//
//   Future citiesByStateId(String stateID);
//
  Future getAboutUs(String langCode);

  Future getPrivacyPolicy(String langCode);

  Future getTermsAndCondition(String langCode);

  Future getContactUs(String langCode);

  Future getFaqContent(String langCode);

  Future<String> sendContactUsMessage(ContactUsStateModel body);

//   Future getCategoryList(String langCode);

  Future getBestSellingProduct(String langCode);

  Future getFilterProductByName(Uri uri);

  Future getAllProductList(String langCode);

  Future getProductDetails(String slug, String langCode);

  Future getCartProduct(String token, String langCode);

  Future<String> addToCart(
      String token, AddToCartModel dataModel, String langCode);

  Future downloadItems(String token, String langCode);

  Future downloadFile(String id, String token, String langCode);

  Future<String> removeCartItem(String id, String token, String langCode);

  Future cartQty(String token);

//   Future getCheckOutInfo(String token);

  Future applyCoupon(Map<String, String> coupon, String token, String langCode);

  Future removeCoupon(String token, String langCode);

  Future getSearchProperty(Uri uri);

  Future getSellerWithdrawInfo(String token, String langCode);

  Future getWithdrawAccountInfo(String id, String token, String langCode);

  Future<String> createNewWithdrawRequest(
      CreateWithdrawStateModel body, String token, String langCode);

  Future<String> sendMessageToAuthor(
      String token, Map<String, dynamic> body, String langCode);

  Future<String> postComment(
      String token, Map<String, dynamic> body, String langCode);

  Future<String> postReview(
      String token, Map<String, dynamic> body, String langCode);

  Future getSelectProductTypeInfo(String token, String langCode);

  Future getUserPortfolio(String token, String langCode);

  Future<String> uploadProduct(
      String token, String langCode, String type, UploadProductStateModel body);

  Future<String> updateProduct(String token, String id, String type,
      String langCode, UpdateStateModel body);

  Future<String> uploadVariant(
      String token, String id, String langCode, VariantStateModel body);

  Future<String> updateVariant(
      String token, String id, String langCode, VariantStateModel body);

  Future<String> deleteProduct(String token, String id, String langCode);

  Future<String> deleteVariant(String token, String id, String langCode);

  Future getEditProductInfo(String token, String id, String langCode);

//   Future downloadExistingScriptFile(String token, String file);
//
//   //payment start
  Future getPaymentPageInformation(String token, String langCode);

  Future<String> bankPayment(Uri uri, Map<String, dynamic> body);

  Future<String> stripePayment(Uri uri, StripePaymentStateModel body);
// //payment end
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  final headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  final postHeader = {
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  @override
  Future login(LoginStateModel body) async {
    final uri = Uri.parse(RemoteUrls.userLogin);

    final clientMethod =
        client.post(uri, headers: postHeader, body: body.toMap());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> userRegistration(SignUpStateModel body) async {
    final uri = Uri.parse(RemoteUrls.userRegistration);

    final clientMethod =
        client.post(uri, headers: postHeader, body: body.toMap());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> newUserVerification(SignUpStateModel body) async {
    final uri = Uri.parse(RemoteUrls.newUserVerification);

    final clientMethod =
        client.post(uri, headers: postHeader, body: body.toMap());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> resendVerificationCode(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.resendVerificationCode);

    final clientMethod = client.post(uri, headers: postHeader, body: body);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> forgotPassword(Map<String, dynamic> body) async {
    final uri = Uri.parse(RemoteUrls.forgotPassWord);

    final clientMethod = client.post(uri, headers: postHeader, body: body);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> updatePassword(PasswordStateModel body) async {
    final uri = Uri.parse(RemoteUrls.updatePassword).replace(queryParameters: {
      'lang_code': body.languageCode,
    });
    debugPrint('update-password-url $uri');
    final clientMethod =
        client.post(uri, headers: postHeader, body: body.toMap());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> logout(Uri uri) async {
    //final uri = Uri.parse(RemoteUrls.logout(uri));

    debugPrint('logout-url $uri');
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getWebsiteSetupData() async {
    final uri = Uri.parse(RemoteUrls.websiteSetup);

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getHomeData(String langCode) async {
    final uri = Uri.parse(RemoteUrls.homeUrl).replace(queryParameters: {
      'lang_code': langCode,
    });
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getUserProfileInfo(String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.myProfileUrl(token, langCode));
    //debugPrint('getUserProfileInfo-url $uri');
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> updateUserInfo(
      ProfileStateModel body, String token, String langCode) async {
    final uri =
        Uri.parse(RemoteUrls.updateUserInfoUrl).replace(queryParameters: {
      'token': token,
      'lang_code': langCode,
    });
    debugPrint('updateUserInfo-url $uri');
    final bodyData = body.toMap();
    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(bodyData);

    request.headers.addAll(headers);
    if (body.image.isNotEmpty) {
      final file = await http.MultipartFile.fromPath('image', body.image);
      request.files.add(file);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> passwordChange(ChangePasswordStateModel changePassData,
      String token, String langCode) async {
    final uri =
        Uri.parse(RemoteUrls.changePasswordUrl).replace(queryParameters: {
      'token': token,
      'lang_code': langCode,
    });

    final clientMethod =
        client.post(uri, headers: postHeader, body: changePassData.toMap());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getWishItemList(String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.wishlistUrl).replace(queryParameters: {
      'token': token,
      'lang_code': langCode,
    });
    debugPrint('wishlist-url $uri');
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> deleteWishListItem(
      String id, String token, String langCode) async {
    final uri =
        Uri.parse(RemoteUrls.wishItemDeleteUrl(id)).replace(queryParameters: {
      'token': token,
      'lang_code': langCode,
    });

    final clientMethod = client.delete(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'];
  }

  @override
  Future<String> addToWish(String id, String token, String langCode) async {
    final uri =
        Uri.parse(RemoteUrls.addToWishUrl(id)).replace(queryParameters: {
      'token': token,
      'lang_code': langCode,
    });

    final clientMethod = client.post(uri, headers: postHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody['message'];
  }

// @override
// Future getCategoryList() async {
//   final uri = Uri.parse(RemoteUrls.getCategoryList);
//
//   final clientMethod = client.get(uri, headers: headers);
//   final responseJsonBody =
//       await NetworkParser.callClientWithCatchException(() => clientMethod);
//   return responseJsonBody;
// }

  @override
  Future getAboutUs(String langCode) async {
    final uri = Uri.parse(RemoteUrls.getAboutUs)
        .replace(queryParameters: {'lang_code': langCode});
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getBestSellingProduct(String langCode) async {
    final uri = Uri.parse(RemoteUrls.getBestSellingProduct)
        .replace(queryParameters: {'lang_code': langCode});
    debugPrint('getBestSellingProduct-url $uri');
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getTermsAndCondition(String langCode) async {
    final uri = Uri.parse(RemoteUrls.getTermsAndCondition)
        .replace(queryParameters: {'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['terms_conditions'];
  }

  @override
  Future getPrivacyPolicy(String langCode) async {
    final uri = Uri.parse(RemoteUrls.getPrivacyPolicy)
        .replace(queryParameters: {'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['privacyPolicy'];
  }

  @override
  Future getContactUs(String langCode) async {
    final uri = Uri.parse(RemoteUrls.getContactUs)
        .replace(queryParameters: {'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getFaqContent(String langCode) async {
    final uri = Uri.parse(RemoteUrls.getFaqContent)
        .replace(queryParameters: {'lang_code': langCode});
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getFilterProductByName(Uri uri) async {
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getAllProductList(String langCode) async {
    final uri = Uri.parse(RemoteUrls.getAllPropertyList)
        .replace(queryParameters: {'lang_code': langCode});
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getProductDetails(String slug, String langCode) async {
    final uri = Uri.parse(RemoteUrls.getProductDetails(slug))
        .replace(queryParameters: {'lang_code': langCode});
    //print('details-url $uri');
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> sendMessageToAuthor(
      String token, Map<String, dynamic> body, String langCode) async {
    final uri = Uri.parse(RemoteUrls.sendMessageToAuthor)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});
    final clientMethod = client.post(uri, headers: postHeader, body: body);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> postComment(
      String token, Map<String, dynamic> body, String langCode) async {
    final uri = Uri.parse(RemoteUrls.postComment)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.post(uri, headers: postHeader, body: body);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> postReview(
      String token, Map<String, dynamic> body, String langCode) async {
    final uri = Uri.parse(RemoteUrls.postReview)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.post(uri, headers: postHeader, body: body);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

// @override
// Future<List<CountryModel>> getCountryList(String token) async {
//   final uri = Uri.parse(RemoteUrls.countryListUrl(token));
//
//   final clientMethod = client.get(uri, headers: headers);
//   final responseJsonBody =
//       await NetworkParser.callClientWithCatchException(() => clientMethod);
//   final mapList = responseJsonBody['countries'] as List;
//
//   return List<CountryModel>.from(mapList.map((e) => CountryModel.fromMap(e)));
// }
//
// @override
// Future statesByCountryId(String countryID) async {
//   final uri = Uri.parse(RemoteUrls.stateByCountryId(countryID));
//
//   final clientMethod = client.get(uri, headers: headers);
//   final responseJsonBody =
//       await NetworkParser.callClientWithCatchException(() => clientMethod);
//
//   return responseJsonBody;
// }
//
// @override
// Future citiesByStateId(String stateID) async {
//   final uri = Uri.parse(RemoteUrls.citiesByStateId(stateID));
//   final clientMethod = client.get(uri, headers: headers);
//   final responseJsonBody =
//       await NetworkParser.callClientWithCatchException(() => clientMethod);
//   return responseJsonBody;
// }

  @override
  Future getSearchProperty(Uri uri) async {
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future getCartProduct(String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.getCartProduct)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> addToCart(
      String token, AddToCartModel dataModel, String langCode) async {
    final uri = Uri.parse(RemoteUrls.addToCartUrl)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});
    final clientMethod =
        client.post(uri, headers: postHeader, body: dataModel.toMap());
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody['message'] as String;
  }

  @override
  Future downloadItems(String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.downloadUrls)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});
    print("urlllllll: $uri");
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future downloadFile(String id, String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.downloadFileUrl(id))
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future<String> removeCartItem(
      String id, String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.removeCartUrl(id))
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.delete(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody['message'] as String;
  }

  @override
  Future cartQty(String token) async {
    final uri = Uri.parse(RemoteUrls.miniCartUrl(token));

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future getSellerWithdrawInfo(String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.getSellerWithdrawInfo)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future getWithdrawAccountInfo(
      String id, String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.getWithdrawAccountInfo(id))
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future<String> createNewWithdrawRequest(
      CreateWithdrawStateModel body, String token, String langCode) async {
    final url = Uri.parse(RemoteUrls.createWithdraw)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod =
        client.post(url, headers: postHeader, body: body.toMap());
    final responseBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseBody["message"] as String;
  }

  @override
  Future getUserPortfolio(String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.getUserPortfolio)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> uploadProduct(String token, String langCode, String type,
      UploadProductStateModel body) async {
    final uri = Uri.parse(RemoteUrls.uploadProduct(type))
        .replace(queryParameters: {'token': token, 'lang_code': langCode});
    debugPrint('upload-product-url $uri');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(body.toMap());

    request.headers.addAll(headers);
    if (body.thumbImage.isNotEmpty) {
      final thumbImage =
          await http.MultipartFile.fromPath('thumb_image', body.thumbImage);
      log('thumb_image ${body.thumbImage}');
      request.files.add(thumbImage);
    }

    if (body.productIcon.isNotEmpty) {
      final productIcon =
          await http.MultipartFile.fromPath('product_icon', body.productIcon);
      log('product_icon ${body.productIcon}');
      request.files.add(productIcon);
    }

    if (body.uploadFile.isNotEmpty) {
      final uploadFile =
          await http.MultipartFile.fromPath('upload_file', body.uploadFile);
      log('upload_file ${body.uploadFile}');
      request.files.add(uploadFile);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> updateProduct(String token, String id, String type,
      String langCode, UpdateStateModel body) async {
    final uri =
        Uri.parse(RemoteUrls.updateProduct(id, type)).replace(queryParameters: {
      'token': token,
      'lang_code': 'en',
      'edit_mode': 'en',
    });
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };
    debugPrint('update-product-route $uri');
    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(body.toMap());

    request.headers.addAll(headers);

    if (body.thumbImage.isNotEmpty) {
      final thumbImage =
          await http.MultipartFile.fromPath('thumb_image', body.thumbImage);
      log('thumb_image ${body.thumbImage}');
      request.files.add(thumbImage);
    }

    if (body.productIcon.isNotEmpty) {
      final productIcon =
          await http.MultipartFile.fromPath('product_icon', body.productIcon);
      log('product_icon ${body.productIcon}');
      request.files.add(productIcon);
    }

    if (body.uploadFile.isNotEmpty) {
      final uploadFile =
          await http.MultipartFile.fromPath('upload_file', body.uploadFile);
      log('upload_file ${body.uploadFile}');
      request.files.add(uploadFile);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> deleteProduct(String token, String id, String langCode) async {
    final uri = Uri.parse(RemoteUrls.deleteProduct(id))
        .replace(queryParameters: {'token': token, 'lang_code': langCode});
    debugPrint('delete-url $uri');
    final clientMethod = client.delete(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> uploadVariant(
      String token, String id, String langCode, VariantStateModel body) async {
    final uri = Uri.parse(RemoteUrls.uploadVariant(id))
        .replace(queryParameters: {'token': token, 'lang_code': langCode});
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(body.toMap());

    request.headers.addAll(headers);
    if (body.fileName.isNotEmpty) {
      final uploadFile =
          await http.MultipartFile.fromPath('file_name', body.fileName);
      debugPrint('file_name ${body.fileName}');
      request.files.add(uploadFile);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> updateVariant(
      String token, String id, String langCode, VariantStateModel body) async {
    final uri = Uri.parse(RemoteUrls.updateVariant(id))
        .replace(queryParameters: {'token': token, 'lang_code': langCode});
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest',
    };

    final request = http.MultipartRequest('POST', uri);
    request.fields.addAll(body.toMap());

    request.headers.addAll(headers);
    if (body.fileName.isNotEmpty) {
      final uploadFile =
          await http.MultipartFile.fromPath('file_name', body.fileName);
      debugPrint('file_name ${body.fileName}');
      request.files.add(uploadFile);
    }

    http.StreamedResponse response = await request.send();
    final clientMethod = http.Response.fromStream(response);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> deleteVariant(String token, String id, String langCode) async {
    final uri = Uri.parse(RemoteUrls.deleteVariant(id))
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.delete(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getEditProductInfo(String token, String id, String langCode) async {
    final uri =
        Uri.parse(RemoteUrls.getEditProductInfo(id)).replace(queryParameters: {
      'token': token,
      'lang_code': langCode,
      'edit_mode': langCode,
    });
    debugPrint('getEditProductInfo $uri');
    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

// @override
// Future downloadExistingScriptFile(String token, String file) async {
//   final uri = Uri.parse(RemoteUrls.downloadExistingScriptFile(token, file));
//
//   final clientMethod = client.get(uri, headers: headers);
//   final responseJsonBody =
//       await NetworkParser.callClientWithCatchException(() => clientMethod);
//   return responseJsonBody;
// }

  @override
  Future<String> bankPayment(Uri uri, Map<String, dynamic> body) async {
    //final uri = Uri.parse(RemoteUrls.bankPayment(token));

    final clientMethod = client.post(uri, body: body, headers: postHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getPaymentPageInformation(String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.getPaymentPageInformation)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody;
  }

  @override
  Future<String> stripePayment(Uri uri, StripePaymentStateModel body) async {
    // final uri = Uri.parse(RemoteUrls.stripePayment(token));
    final clientMethod =
        client.post(uri, body: body.toMap(), headers: postHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future<String> sendContactUsMessage(ContactUsStateModel body) async {
    final uri = Uri.parse(RemoteUrls.sendContactUsMessage)
        .replace(queryParameters: {'lang_code': body.langCode});

    final clientMethod =
        client.post(uri, body: body.toMap(), headers: postHeader);

    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);
    return responseJsonBody['message'] as String;
  }

  @override
  Future getSelectProductTypeInfo(String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.getSelectProductTypeInfo)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future applyCoupon(
      Map<String, String> coupon, String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.couponInfoUrl)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.post(uri, body: coupon, headers: postHeader);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

  @override
  Future removeCoupon(String token, String langCode) async {
    final uri = Uri.parse(RemoteUrls.couponRemoveUrl)
        .replace(queryParameters: {'token': token, 'lang_code': langCode});

    final clientMethod = client.get(uri, headers: headers);
    final responseJsonBody =
        await NetworkParser.callClientWithCatchException(() => clientMethod);

    return responseJsonBody;
  }

// @override
// Future getCheckOutInfo(String token) async {
//   final uri = Uri.parse(RemoteUrls.checkOutUrl(token));
//
//   final clientMethod = client.get(uri, headers: headers);
//   final responseJsonBody =
//       await NetworkParser.callClientWithCatchException(() => clientMethod);
//
//   return responseJsonBody;
// }
}

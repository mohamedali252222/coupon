import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/errors/exception.dart';
import '../../presentation/utils/k_string.dart';
import '../models/auth_response/user_response_model.dart';
import '../models/cart/coupon_model.dart';
import '../models/setting/website_setup_model.dart';

abstract class LocalDataSource {
  bool checkOnBoarding();

  Future<bool> cachedOnBoarding();

  Future<bool> cacheUserResponse(UserResponseModel userResponseModel);

  //Future<bool> cacheCouponResponse(CouponDto couponDto);

  CouponDto getCouponData();

  Future<bool> cacheCouponResponse(CouponDto couponDto);

  WebsiteSetupModel getCatchWebsiteSetupData();

  UserResponseModel getExistingUserInfo();

  Future<bool> clearUserResponse();

  Future<bool> clearCouponResponse();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cachedOnBoarding() async {
    return sharedPreferences.setBool(KString.cachedOnBoardingKey, true);
  }

  @override
  Future<bool> cacheCouponResponse(CouponDto couponDto) {
    return sharedPreferences.setString(
        KString.cacheCouponResponseKey, couponDto.toJson());
  }

  @override
  bool checkOnBoarding() {
    final jsonString = sharedPreferences.getBool(KString.cachedOnBoardingKey);
    if (jsonString != null) {
      return true;
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheUserResponse(UserResponseModel userResponseModel) {
    return sharedPreferences.setString(
        KString.getExistingUserResponseKey, userResponseModel.toJson());
  }

  // @override
  // Future<bool> cacheCouponResponse(CouponDto couponDto) {
  //   return sharedPreferences.setString(
  //       KString.cacheCouponResponseKey, couponDto.toJson());
  // }

  @override
  UserResponseModel getExistingUserInfo() {
    final jsonData =
        sharedPreferences.getString(KString.getExistingUserResponseKey);
    if (jsonData != null) {
      print('savedDaaaaa $jsonData');
      return UserResponseModel.fromJson(jsonData);
    } else {
      throw const DatabaseException('Not save users');
    }
  }

  @override
  Future<bool> clearUserResponse() {
    return sharedPreferences.remove(KString.getExistingUserResponseKey);
  }

  @override
  Future<bool> clearCouponResponse() {
    return sharedPreferences.remove(KString.cacheCouponResponseKey);
  }

  @override
  WebsiteSetupModel getCatchWebsiteSetupData() {
    final jsonString = sharedPreferences.getString(KString.cachedWebSettingKey);
    //log(jsonString.toString(), name: _className);
    if (jsonString != null) {
      return WebsiteSetupModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  CouponDto getCouponData() {
    final jsonString =
        sharedPreferences.getString(KString.cacheCouponResponseKey);
    //log(jsonString.toString(), name: _className);
    if (jsonString != null) {
      return CouponDto.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }
}

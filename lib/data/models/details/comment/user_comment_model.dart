import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserCommentModel extends Equatable {
  final int id;
  final String name;
  final String userName;
  final String email;
  final String emailVerifiedAt;
  final String forgetPasswordToken;
  final String forgetPasswordOtp;
  final int status;
  final String providerId;
  final String provider;
  final String providerAvatar;
  final String image;
  final String phone;
  final int countryId;
  final int stateId;
  final int cityId;
  final String zipCode;
  final String address;
  final int isProvider;
  final String verifyToken;
  final String otpMailVerifyToken;
  final int emailVerified;
  final int agreePolicy;
  final String designation;
  final String aboutMe;
  final String facebook;
  final String pinterest;
  final String linkedIn;
  final String dribbble;
  final String twitter;
  final String mySkill;
  final String createdAt;
  final String updatedAt;

  const UserCommentModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.emailVerifiedAt,
    required this.forgetPasswordToken,
    required this.forgetPasswordOtp,
    required this.status,
    required this.providerId,
    required this.provider,
    required this.providerAvatar,
    required this.image,
    required this.phone,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.zipCode,
    required this.address,
    required this.isProvider,
    required this.verifyToken,
    required this.otpMailVerifyToken,
    required this.emailVerified,
    required this.agreePolicy,
    required this.designation,
    required this.aboutMe,
    required this.facebook,
    required this.pinterest,
    required this.linkedIn,
    required this.dribbble,
    required this.twitter,
    required this.mySkill,
    required this.createdAt,
    required this.updatedAt,
  });

  UserCommentModel copyWith({
    int? id,
    String? name,
    String? userName,
    String? email,
    String? emailVerifiedAt,
    String? forgetPasswordToken,
    String? forgetPasswordOtp,
    int? status,
    String? providerId,
    String? provider,
    String? providerAvatar,
    String? image,
    String? phone,
    int? countryId,
    int? stateId,
    int? cityId,
    String? zipCode,
    String? address,
    int? isProvider,
    String? verifyToken,
    String? otpMailVerifyToken,
    int? emailVerified,
    int? agreePolicy,
    String? designation,
    String? aboutMe,
    String? facebook,
    String? pinterest,
    String? linkedIn,
    String? dribbble,
    String? twitter,
    String? mySkill,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserCommentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      forgetPasswordToken: forgetPasswordToken ?? this.forgetPasswordToken,
      forgetPasswordOtp: forgetPasswordOtp ?? this.forgetPasswordOtp,
      status: status ?? this.status,
      providerId: providerId ?? this.providerId,
      provider: provider ?? this.provider,
      providerAvatar: providerAvatar ?? this.providerAvatar,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      zipCode: zipCode ?? this.zipCode,
      address: address ?? this.address,
      isProvider: isProvider ?? this.isProvider,
      verifyToken: verifyToken ?? this.verifyToken,
      otpMailVerifyToken: otpMailVerifyToken ?? this.otpMailVerifyToken,
      emailVerified: emailVerified ?? this.emailVerified,
      agreePolicy: agreePolicy ?? this.agreePolicy,
      designation: designation ?? this.designation,
      aboutMe: aboutMe ?? this.aboutMe,
      facebook: facebook ?? this.facebook,
      pinterest: pinterest ?? this.pinterest,
      linkedIn: linkedIn ?? this.linkedIn,
      dribbble: dribbble ?? this.dribbble,
      twitter: twitter ?? this.twitter,
      mySkill: mySkill ?? this.mySkill,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'user_name': userName,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'forget_password_token': forgetPasswordToken,
      'forget_password_otp': forgetPasswordOtp,
      'status': status,
      'provider_id': providerId,
      'provider': provider,
      'provider_avatar': providerAvatar,
      'image': image,
      'phone': phone,
      'country_id': countryId,
      'state_id': stateId,
      'city_id': cityId,
      'zip_code': zipCode,
      'address': address,
      'is_provider': isProvider,
      'verify_token': verifyToken,
      'otp_mail_verify_token': otpMailVerifyToken,
      'email_verified': emailVerified,
      'agree_policy': agreePolicy,
      'designation': designation,
      'about_me': aboutMe,
      'facebook': facebook,
      'pinterest': pinterest,
      'linkedIn': linkedIn,
      'dribbble': dribbble,
      'twitter': twitter,
      'my_skill': mySkill,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory UserCommentModel.fromMap(Map<String, dynamic> map) {
    return UserCommentModel(
      id: map['id'] as int,
      name: map['name'] ?? '',
      userName: map['user_name'] ?? '',
      email: map['email'] ?? '',
      emailVerifiedAt: map['email_verified_at'] ?? '',
      forgetPasswordToken: map['forget_password_token'] ?? '',
      forgetPasswordOtp: map['forget_password_otp'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      providerId: map['provider_id'] ?? '',
      provider: map['provider'] ?? '',
      providerAvatar: map['provider_avatar'] ?? '',
      image: map['image'] ?? '',
      phone: map['phone'] ?? '',
      countryId: map['country_id'] != null
          ? int.parse(map['country_id'].toString())
          : 0,
      stateId:
          map['state_id'] != null ? int.parse(map['state_id'].toString()) : 0,
      cityId: map['city_id'] != null ? int.parse(map['city_id'].toString()) : 0,
      zipCode: map['zip_code'] ?? '',
      address: map['address'] ?? '',
      isProvider: map['is_provider'] != null
          ? int.parse(map['is_provider'].toString())
          : 0,
      verifyToken: map['verify_token'] ?? '',
      otpMailVerifyToken: map['otp_mail_verify_token'] ?? '',
      emailVerified: map['email_verified'] != null
          ? int.parse(map['email_verified'].toString())
          : 0,
      agreePolicy: map['agree_policy'] != null
          ? int.parse(map['agree_policy'].toString())
          : 0,
      designation: map['designation'] ?? '',
      aboutMe: map['about_me'] ?? '',
      facebook: map['facebook'] ?? '',
      pinterest: map['pinterest'] ?? '',
      linkedIn: map['linkedIn'] ?? '',
      dribbble: map['dribbble'] ?? '',
      twitter: map['twitter'] ?? '',
      mySkill: map['my_skill'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCommentModel.fromJson(String source) =>
      UserCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      userName,
      email,
      emailVerifiedAt,
      forgetPasswordToken,
      forgetPasswordOtp,
      status,
      providerId,
      provider,
      providerAvatar,
      image,
      phone,
      countryId,
      stateId,
      cityId,
      zipCode,
      address,
      isProvider,
      verifyToken,
      otpMailVerifyToken,
      emailVerified,
      agreePolicy,
      designation,
      aboutMe,
      facebook,
      pinterest,
      linkedIn,
      dribbble,
      twitter,
      mySkill,
      createdAt,
      updatedAt,
    ];
  }
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'profile_cubit.dart';

class ProfileStateModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String userName;
  final int status;
  final String image;
  final String address;
  final String designation;
  final String aboutMe;
  final String mySkill;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String dribbble;
  final String pinterest;
  final String country;
  final String state;
  final String city;
  final String langCode;
  final ProfileState profileState;

  const ProfileStateModel({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.userName = '',
    this.status = 0,
    this.image = '',
    this.address = '',
    this.designation = '',
    this.aboutMe = '',
    this.mySkill = '',
    this.facebook = '',
    this.twitter = '',
    this.linkedin = '',
    this.dribbble = '',
    this.pinterest = '',
    this.country = '',
    this.state = '',
    this.city = '',
    this.langCode = '',
    this.profileState = const ProfileInitial(),
  });

  ProfileStateModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? userName,
    int? status,
    String? image,
    String? address,
    String? designation,
    String? aboutMe,
    String? mySkill,
    String? facebook,
    String? twitter,
    String? linkedin,
    String? dribbble,
    String? pinterest,
    String? country,
    String? state,
    String? city,
    String? langCode,
    ProfileState? profileState,
  }) {
    return ProfileStateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      userName: userName ?? this.userName,
      status: status ?? this.status,
      image: image ?? this.image,
      address: address ?? this.address,
      designation: designation ?? this.designation,
      aboutMe: aboutMe ?? this.aboutMe,
      mySkill: mySkill ?? this.mySkill,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      dribbble: dribbble ?? this.dribbble,
      pinterest: pinterest ?? this.pinterest,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      langCode: langCode ?? this.langCode,
      profileState: profileState ?? this.profileState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'id': id.toString(),
      'name': name,
      'email': email,
      'phone': phone,
      'user_name': userName,
      'status': status.toString(),
      'image': image,
      'address': address,
      'designation': designation,
      'about_me': aboutMe,
      'my_skill': mySkill,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'dribbble': dribbble,
      'pinterest': pinterest,
      'country': country,
      'state': state,
      'lang_code': langCode,
      'city': city,
    };
  }

  factory ProfileStateModel.fromMap(Map<String, dynamic> map) {
    return ProfileStateModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      userName: map['user_name'] ?? '',
      status: map['status'] ?? 0,
      image: map['image'] ?? '',
      address: map['address'] ?? '',
      designation: map['designation'] ?? '',
      aboutMe: map['about_me'] ?? '',
      mySkill: map['my_skill'] ?? '',
      facebook: map['facebook'] ?? '',
      twitter: map['twitter'] ?? '',
      linkedin: map['linkedin'] ?? '',
      dribbble: map['dribbble'] ?? '',
      pinterest: map['pinterest'] ?? '',
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileStateModel.fromJson(String source) =>
      ProfileStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      phone,
      userName,
      status,
      image,
      address,
      designation,
      aboutMe,
      mySkill,
      facebook,
      twitter,
      linkedin,
      dribbble,
      pinterest,
      country,
      state,
      city,
      langCode,
      profileState,
    ];
  }
}

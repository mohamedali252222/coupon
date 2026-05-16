import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
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

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userName,
    required this.status,
    required this.image,
    required this.address,
    required this.designation,
    required this.aboutMe,
    required this.mySkill,
    required this.facebook,
    required this.twitter,
    required this.linkedin,
    required this.dribbble,
    required this.pinterest,
    required this.country,
    required this.state,
    required this.city,
  });

  UserModel copyWith({
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
  }) {
    return UserModel(
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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'user_name': userName,
      'status': status,
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
      'city': city,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? int.parse(map['id'].toString()) : 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      userName: map['user_name'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
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

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
    ];
  }
}

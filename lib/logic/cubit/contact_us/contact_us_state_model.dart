import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'contact_us_cubit.dart';

class ContactUsStateModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String subject;
  final String message;
  final String langCode;
  final ContactUsState contactUsState;

  const ContactUsStateModel({
    this.name = '',
    this.email = '',
    this.langCode = '',
    this.phone = '',
    this.subject = '',
    this.message = '',
    this.contactUsState = const ContactUsInitial(),
  });

  ContactUsStateModel copyWith({
    String? name,
    String? email,
    String? langCode,
    String? phone,
    String? subject,
    String? message,
    ContactUsState? contactUsState,
  }) {
    return ContactUsStateModel(
      name: name ?? this.name,
      email: email ?? this.email,
      langCode: langCode ?? this.langCode,
      phone: phone ?? this.phone,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      contactUsState: contactUsState ?? this.contactUsState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'name': name,
      'email': email,
      'lang_code': langCode,
      'phone': phone,
      'subject': subject,
      'message': message,
    };
  }

  ContactUsStateModel clear() {
    return const ContactUsStateModel(
      name: '',
      email: '',
      //langCode: '',
      phone: '',
      subject: '',
      message: '',
      //contactUsState: ContactUsInitial(),
    );
  }

  static ContactUsStateModel init() {
    return const ContactUsStateModel(
      name: '',
      email: '',
      langCode: '',
      phone: '',
      subject: '',
      message: '',
      contactUsState: ContactUsInitial(),
    );
  }

  factory ContactUsStateModel.fromMap(Map<String, dynamic> map) {
    return ContactUsStateModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      subject: map['subject'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsStateModel.fromJson(String source) =>
      ContactUsStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      email,
      langCode,
      phone,
      subject,
      message,
      contactUsState,
    ];
  }
}

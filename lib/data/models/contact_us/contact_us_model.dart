import 'dart:convert';

import 'package:equatable/equatable.dart';

class ContactUsModel extends Equatable {
  // final SeoSettingModel? seoSetting;
  final ContactComponent? contact;

  const ContactUsModel({
    // required this.seoSetting,
    required this.contact,
  });

  ContactUsModel copyWith({
    // SeoSettingModel? seoSetting,
    ContactComponent? contact,
  }) {
    return ContactUsModel(
      // seoSetting: seoSetting ?? this.seoSetting,
      contact: contact ?? this.contact,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'seo_setting': seoSetting?.toMap(),
      'contact': contact?.toMap(),
    };
  }

  factory ContactUsModel.fromMap(Map<String, dynamic> map) {
    return ContactUsModel(
      // seoSetting: map['seo_setting'] != null
      //     ? SeoSettingModel.fromMap(map['seo_setting'] as Map<String, dynamic>)
      //     : null,
      contact: map['contact'] != null
          ? ContactComponent.fromMap(map['contact'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsModel.fromJson(String source) =>
      ContactUsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [contact!];
}

class SeoSettingModel extends Equatable {
  final int id;
  final String pageName;
  final String seoTitle;
  final String seoDescription;
  final String createdAt;
  final String updatedAt;

  const SeoSettingModel({
    required this.id,
    required this.pageName,
    required this.seoTitle,
    required this.seoDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  SeoSettingModel copyWith({
    int? id,
    String? pageName,
    String? seoTitle,
    String? seoDescription,
    String? createdAt,
    String? updatedAt,
  }) {
    return SeoSettingModel(
      id: id ?? this.id,
      pageName: pageName ?? this.pageName,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'page_name': pageName,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SeoSettingModel.fromMap(Map<String, dynamic> map) {
    return SeoSettingModel(
      id: map['id'] ?? 0,
      pageName: map['page_name'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SeoSettingModel.fromJson(String source) =>
      SeoSettingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      pageName,
      seoTitle,
      seoDescription,
      createdAt,
      updatedAt,
    ];
  }
}

class ContactComponent extends Equatable {
  final int id;
  final String supporterImage;
  final String title1;
  final String title2;
  final String icon;
  final String time;
  final String offDay;
  final String image;
  final String description;
  final String email;
  final String address;
  final String phone;
  final String map;
  final String createdAt;
  final String updatedAt;
  final ContactUsLangFrontEnd? contactlangfrontend;

  const ContactComponent({
    required this.id,
    required this.supporterImage,
    required this.title1,
    required this.title2,
    required this.icon,
    required this.time,
    required this.offDay,
    required this.image,
    required this.description,
    required this.email,
    required this.address,
    required this.phone,
    required this.map,
    required this.createdAt,
    required this.updatedAt,
    required this.contactlangfrontend,
  });

  ContactComponent copyWith({
    int? id,
    String? supporterImage,
    String? title1,
    String? title2,
    String? icon,
    String? time,
    String? offDay,
    String? image,
    String? description,
    String? email,
    String? address,
    String? phone,
    String? map,
    String? createdAt,
    String? updatedAt,
    ContactUsLangFrontEnd? contactlangfrontend,
  }) {
    return ContactComponent(
      id: id ?? this.id,
      supporterImage: supporterImage ?? this.supporterImage,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      icon: icon ?? this.icon,
      time: time ?? this.time,
      offDay: offDay ?? this.offDay,
      image: image ?? this.image,
      description: description ?? this.description,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      map: map ?? this.map,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      contactlangfrontend: contactlangfrontend ?? this.contactlangfrontend,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'supporter_image': supporterImage,
      'title1': title1,
      'title2': title2,
      'icon': icon,
      'time': time,
      'off_day': offDay,
      'image': image,
      'description': description,
      'email': email,
      'address': address,
      'phone': phone,
      'map': map,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'contactlangfrontend': contactlangfrontend?.toMap(),
    };
  }

  factory ContactComponent.fromMap(Map<String, dynamic> map) {
    return ContactComponent(
      id: map['id'] ?? 0,
      supporterImage: map['supporter_image'] ?? '',
      title1: map['title1'] ?? '',
      title2: map['title2'] ?? '',
      icon: map['icon'] ?? '',
      time: map['time'] ?? '',
      offDay: map['off_day'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      map: map['map'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      contactlangfrontend: map['contactlangfrontend'] != null
          ? ContactUsLangFrontEnd.fromMap(
              map['contactlangfrontend'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactComponent.fromJson(String source) =>
      ContactComponent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      supporterImage,
      title1,
      title2,
      icon,
      time,
      offDay,
      image,
      description,
      email,
      address,
      phone,
      map,
      createdAt,
      updatedAt,
      contactlangfrontend!,
    ];
  }
}

class ContactUsLangFrontEnd extends Equatable {
  final int id;
  final int contactId;
  final String langCode;
  final String title1;
  final String title2;
  final String time;
  final String offDay;
  final String address;
  final String phone;
  final String createdAt;
  final String updatedAt;

  const ContactUsLangFrontEnd({
    required this.id,
    required this.contactId,
    required this.langCode,
    required this.title1,
    required this.title2,
    required this.time,
    required this.offDay,
    required this.address,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  ContactUsLangFrontEnd copyWith({
    int? id,
    int? contactId,
    String? langCode,
    String? title1,
    String? title2,
    String? time,
    String? offDay,
    String? address,
    String? phone,
    String? createdAt,
    String? updatedAt,
  }) {
    return ContactUsLangFrontEnd(
      id: id ?? this.id,
      contactId: contactId ?? this.contactId,
      langCode: langCode ?? this.langCode,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      time: time ?? this.time,
      offDay: offDay ?? this.offDay,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'contact_id': contactId,
      'lang_code': langCode,
      'title1': title1,
      'title2': title2,
      'time': time,
      'off_day': offDay,
      'address': address,
      'phone': phone,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ContactUsLangFrontEnd.fromMap(Map<String, dynamic> map) {
    return ContactUsLangFrontEnd(
      id: map['id'] ?? 0,
      contactId: map['contact_id'] != null
          ? int.parse(map['contact_id'].toString())
          : 0,
      langCode: map['lang_code'] ?? '',
      title1: map['title1'] ?? '',
      title2: map['title2'] ?? '',
      time: map['time'] ?? '',
      offDay: map['off_day'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsLangFrontEnd.fromJson(String source) =>
      ContactUsLangFrontEnd.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      contactId,
      langCode,
      title1,
      title2,
      time,
      offDay,
      address,
      phone,
      createdAt,
      updatedAt,
    ];
  }
}

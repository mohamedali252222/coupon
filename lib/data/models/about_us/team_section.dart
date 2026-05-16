import 'dart:convert';

import 'package:equatable/equatable.dart';

class OurTeemSection extends Equatable {
  final bool visibility;
  final String title;
  final String description;
  final List<OurTeems>? ourTeems;
  final String offerTitle1;
  final String offerTitle2;
  final String offerTitle3;
  final String offerLink;
  final String offerBackground;

  const OurTeemSection({
    required this.visibility,
    required this.title,
    required this.description,
    required this.ourTeems,
    required this.offerTitle1,
    required this.offerTitle2,
    required this.offerTitle3,
    required this.offerLink,
    required this.offerBackground,
  });

  OurTeemSection copyWith({
    bool? visibility,
    String? title,
    String? description,
    List<OurTeems>? ourTeems,
    String? offerTitle1,
    String? offerTitle2,
    String? offerTitle3,
    String? offerLink,
    String? offerBackground,
  }) {
    return OurTeemSection(
      visibility: visibility ?? this.visibility,
      title: title ?? this.title,
      description: description ?? this.description,
      ourTeems: ourTeems ?? this.ourTeems,
      offerTitle1: offerTitle1 ?? this.offerTitle1,
      offerTitle2: offerTitle2 ?? this.offerTitle2,
      offerTitle3: offerTitle3 ?? this.offerTitle3,
      offerLink: offerLink ?? this.offerLink,
      offerBackground: offerBackground ?? this.offerBackground,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'title': title,
      'description': description,
      'our_teems': ourTeems!.map((x) => x.toMap()).toList(),
      'offer_title1': offerTitle1,
      'offer_title2': offerTitle2,
      'offer_title3': offerTitle3,
      'offer_link': offerLink,
      'offer_background': offerBackground,
    };
  }

  factory OurTeemSection.fromMap(Map<String, dynamic> map) {
    return OurTeemSection(
      visibility: map['visibility'] ?? true,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      ourTeems: map['our_teems'] != null
          ? List<OurTeems>.from(
              (map['our_teems'] as List<dynamic>).map<OurTeems?>(
                (x) => OurTeems.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      offerTitle1: map['offer_title1'] ?? '',
      offerTitle2: map['offer_title2'] ?? '',
      offerTitle3: map['offer_title3'] ?? '',
      offerLink: map['offer_link'] ?? '',
      offerBackground: map['offer_background'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OurTeemSection.fromJson(String source) =>
      OurTeemSection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      visibility,
      title,
      description,
      ourTeems!,
      offerTitle1,
      offerTitle2,
      offerTitle3,
      offerLink,
      offerBackground,
    ];
  }
}

class OurTeems extends Equatable {
  final int id;
  final String image;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String instagram;
  final int status;
  final String createdAt;
  final String updatedAt;
  final TeamLangFrontEnd? teamlangfrontend;

  const OurTeems({
    required this.id,
    required this.image,
    required this.facebook,
    required this.twitter,
    required this.linkedin,
    required this.instagram,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.teamlangfrontend,
  });

  OurTeems copyWith({
    int? id,
    String? image,
    String? facebook,
    String? twitter,
    String? linkedin,
    String? instagram,
    int? status,
    String? createdAt,
    String? updatedAt,
    TeamLangFrontEnd? teamlangfrontend,
  }) {
    return OurTeems(
      id: id ?? this.id,
      image: image ?? this.image,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      instagram: instagram ?? this.instagram,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      teamlangfrontend: teamlangfrontend ?? this.teamlangfrontend,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'teamlangfrontend': teamlangfrontend!.toMap(),
    };
  }

  factory OurTeems.fromMap(Map<String, dynamic> map) {
    return OurTeems(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      facebook: map['facebook'] ?? '',
      twitter: map['twitter'] ?? '',
      linkedin: map['linkedin'] ?? '',
      instagram: map['instagram'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      teamlangfrontend: map['teamlangfrontend'] != null
          ? TeamLangFrontEnd.fromMap(
              map['teamlangfrontend'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OurTeems.fromJson(String source) =>
      OurTeems.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      image,
      facebook,
      twitter,
      linkedin,
      instagram,
      status,
      createdAt,
      updatedAt,
      teamlangfrontend!,
    ];
  }
}

class TeamLangFrontEnd extends Equatable {
  final int id;
  final int teamId;
  final String langCode;
  final String name;
  final String designation;
  final String createdAt;
  final String updatedAt;

  const TeamLangFrontEnd({
    required this.id,
    required this.teamId,
    required this.langCode,
    required this.name,
    required this.designation,
    required this.createdAt,
    required this.updatedAt,
  });

  TeamLangFrontEnd copyWith({
    int? id,
    int? teamId,
    String? langCode,
    String? name,
    String? designation,
    String? createdAt,
    String? updatedAt,
  }) {
    return TeamLangFrontEnd(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      langCode: langCode ?? this.langCode,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'team_id': teamId,
      'lang_code': langCode,
      'name': name,
      'designation': designation,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory TeamLangFrontEnd.fromMap(Map<String, dynamic> map) {
    return TeamLangFrontEnd(
      id: map['id'] ?? 0,
      teamId: map['team_id'] != null ? int.parse(map['team_id'].toString()) : 0,
      langCode: map['lang_code'] ?? '',
      name: map['name'] ?? '',
      designation: map['designation'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamLangFrontEnd.fromJson(String source) =>
      TeamLangFrontEnd.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      teamId,
      langCode,
      name,
      designation,
      createdAt,
      updatedAt,
    ];
  }
}

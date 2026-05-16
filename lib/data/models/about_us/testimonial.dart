import 'dart:convert';

import 'package:equatable/equatable.dart';

class TestimonialSection extends Equatable {
  final bool visibility;
  final String title;
  final String description;
  final List<Testimonials>? testimonials;

  const TestimonialSection({
    required this.visibility,
    required this.title,
    required this.description,
    required this.testimonials,
  });

  TestimonialSection copyWith({
    bool? visibility,
    String? title,
    String? description,
    List<Testimonials>? testimonials,
  }) {
    return TestimonialSection(
      visibility: visibility ?? this.visibility,
      title: title ?? this.title,
      description: description ?? this.description,
      testimonials: testimonials ?? this.testimonials,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visibility': visibility,
      'title': title,
      'description': description,
      'testimonials': testimonials!.map((x) => x.toMap()).toList(),
    };
  }

  factory TestimonialSection.fromMap(Map<String, dynamic> map) {
    return TestimonialSection(
      visibility: map['visibility'] ?? true,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      testimonials: map['testimonials'] != null
          ? List<Testimonials>.from(
              (map['testimonials'] as List<dynamic>).map<Testimonials?>(
                (x) => Testimonials.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory TestimonialSection.fromJson(String source) =>
      TestimonialSection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [visibility, title, description, testimonials!];
}

class Testimonials extends Equatable {
  final int id;
  final String image;
  final double rating;
  final int status;
  final String createdAt;
  final String updatedAt;
  final TestimonialLangFrontEnd? testimoniallangfrontend;

  const Testimonials({
    required this.id,
    required this.image,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.testimoniallangfrontend,
  });

  Testimonials copyWith({
    int? id,
    String? image,
    double? rating,
    int? status,
    String? createdAt,
    String? updatedAt,
    TestimonialLangFrontEnd? testimoniallangfrontend,
  }) {
    return Testimonials(
      id: id ?? this.id,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      testimoniallangfrontend:
          testimoniallangfrontend ?? this.testimoniallangfrontend,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'rating': rating,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'testimoniallangfrontend': testimoniallangfrontend!.toMap(),
    };
  }

  factory Testimonials.fromMap(Map<String, dynamic> map) {
    return Testimonials(
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      rating:
          map['rating'] != null ? double.parse(map['rating'].toString()) : 0.0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      testimoniallangfrontend: map['testimoniallangfrontend'] != null
          ? TestimonialLangFrontEnd.fromMap(
              map['testimoniallangfrontend'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Testimonials.fromJson(String source) =>
      Testimonials.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      image,
      rating,
      status,
      createdAt,
      updatedAt,
      testimoniallangfrontend!,
    ];
  }
}

class TestimonialLangFrontEnd extends Equatable {
  final int id;
  final int testimonialId;
  final String langCode;
  final String name;
  final String designation;
  final String comment;
  final String createdAt;
  final String updatedAt;

  const TestimonialLangFrontEnd({
    required this.id,
    required this.testimonialId,
    required this.langCode,
    required this.name,
    required this.designation,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  TestimonialLangFrontEnd copyWith({
    int? id,
    int? testimonialId,
    String? langCode,
    String? name,
    String? designation,
    String? comment,
    String? createdAt,
    String? updatedAt,
  }) {
    return TestimonialLangFrontEnd(
      id: id ?? this.id,
      testimonialId: testimonialId ?? this.testimonialId,
      langCode: langCode ?? this.langCode,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'testimonial_id': testimonialId,
      'lang_code': langCode,
      'name': name,
      'designation': designation,
      'comment': comment,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory TestimonialLangFrontEnd.fromMap(Map<String, dynamic> map) {
    return TestimonialLangFrontEnd(
      id: map['id'] ?? 0,
      testimonialId: map['testimonial_id'] != null
          ? int.parse(map['testimonial_id'].toString())
          : 0,
      langCode: map['lang_code'] ?? '',
      name: map['name'] ?? '',
      designation: map['designation'] ?? '',
      comment: map['comment'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TestimonialLangFrontEnd.fromJson(String source) =>
      TestimonialLangFrontEnd.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      testimonialId,
      langCode,
      name,
      designation,
      comment,
      createdAt,
      updatedAt,
    ];
  }
}

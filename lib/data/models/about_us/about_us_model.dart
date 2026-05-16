import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'about_section.dart';
import 'elements_model.dart';
import 'team_section.dart';
import 'testimonial.dart';

class AboutUsModel extends Equatable {
  final AboutUs? aboutUs;
  final OurTeemSection? ourTeemSection;
  final WhyChooseUs? whyChooseUs;
  final TestimonialSection? testimonialSection;
  final CounterSection? counterSection;
  final List<Partners>? partners;

  const AboutUsModel({
    required this.aboutUs,
    required this.ourTeemSection,
    required this.whyChooseUs,
    required this.testimonialSection,
    required this.counterSection,
    required this.partners,
  });

  AboutUsModel copyWith({
    AboutUs? aboutUs,
    OurTeemSection? ourTeemSection,
    WhyChooseUs? whyChooseUs,
    TestimonialSection? testimonialSection,
    CounterSection? counterSection,
    List<Partners>? partners,
  }) {
    return AboutUsModel(
      aboutUs: aboutUs ?? this.aboutUs,
      ourTeemSection: ourTeemSection ?? this.ourTeemSection,
      whyChooseUs: whyChooseUs ?? this.whyChooseUs,
      testimonialSection: testimonialSection ?? this.testimonialSection,
      counterSection: counterSection ?? this.counterSection,
      partners: partners ?? this.partners,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'about_us': aboutUs!.toMap(),
      'our_teem_section': ourTeemSection!.toMap(),
      'why_choose_us': whyChooseUs!.toMap(),
      'testimonial_section': testimonialSection!.toMap(),
      'counter_section': counterSection!.toMap(),
      'partners': partners!.map((x) => x.toMap()).toList(),
    };
  }

  factory AboutUsModel.fromMap(Map<String, dynamic> map) {
    return AboutUsModel(
      aboutUs: map['about_us'] != null
          ? AboutUs.fromMap(map['about_us'] as Map<String, dynamic>)
          : null,
      ourTeemSection: map['our_teem_section'] != null
          ? OurTeemSection.fromMap(
              map['our_teem_section'] as Map<String, dynamic>)
          : null,
      whyChooseUs: map['why_choose_us'] != null
          ? WhyChooseUs.fromMap(map['why_choose_us'] as Map<String, dynamic>)
          : null,
      testimonialSection: map['testimonial_section'] != null
          ? TestimonialSection.fromMap(
              map['testimonial_section'] as Map<String, dynamic>)
          : null,
      counterSection: map['counter_section'] != null
          ? CounterSection.fromMap(
              map['counter_section'] as Map<String, dynamic>)
          : null,
      partners: map['partners'] != null
          ? List<Partners>.from(
              (map['partners'] as List<dynamic>).map<Partners?>(
                (x) => Partners.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutUsModel.fromJson(String source) =>
      AboutUsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      aboutUs!,
      ourTeemSection!,
      whyChooseUs!,
      testimonialSection!,
      counterSection!,
      partners!,
    ];
  }
}

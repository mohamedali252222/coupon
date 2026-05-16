import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'category/home_category_model.dart';
import 'choose_us/choose_model.dart';
import 'counter/counter_model.dart';
import 'introduction/introduction_model.dart';
import 'offer/special_offer_model.dart';
import 'partner/partner_model.dart';
import 'product/product_model.dart';
import 'product/trending_product.dart';
import 'setting/home_setting_model.dart';
import 'template/template_model.dart';

class HomeModel extends Equatable {
  final IntroductionModel? introduction;
  final CategoryModel? category;
  final ProductModel? product;
  final CounterModel? counterSection;
  final HomeSetting? setting;
  final SpecialOfferModel? specialOffer;
  final TemplateModel? templateSection;
  final TrendingProductModel? trendingSection;
  final ProductModel? featureSection;
  final ProductModel? popularTrending;
  final ChooseModel? whyChooseUs;
  final bool partnerVisibility;
  final PartnerModel? partnerSection;

  const HomeModel({
    required this.introduction,
    required this.category,
    required this.product,
    required this.counterSection,
    required this.setting,
    required this.specialOffer,
    required this.templateSection,
    required this.trendingSection,
    required this.featureSection,
    required this.popularTrending,
    required this.whyChooseUs,
    required this.partnerVisibility,
    required this.partnerSection,
  });

  HomeModel copyWith({
    IntroductionModel? introduction,
    CategoryModel? category,
    ProductModel? product,
    CounterModel? counterSection,
    HomeSetting? setting,
    SpecialOfferModel? specialOffer,
    TemplateModel? templateSection,
    TrendingProductModel? trendingSection,
    ProductModel? featureSection,
    ProductModel? popularTrending,
    ChooseModel? whyChooseUs,
    bool? partnerVisibility,
    PartnerModel? partnerSection,
  }) {
    return HomeModel(
      introduction: introduction ?? this.introduction,
      category: category ?? this.category,
      product: product ?? this.product,
      counterSection: counterSection ?? this.counterSection,
      setting: setting ?? this.setting,
      specialOffer: specialOffer ?? this.specialOffer,
      templateSection: templateSection ?? this.templateSection,
      trendingSection: trendingSection ?? this.trendingSection,
      featureSection: featureSection ?? this.featureSection,
      popularTrending: popularTrending ?? this.popularTrending,
      whyChooseUs: whyChooseUs ?? this.whyChooseUs,
      partnerVisibility: partnerVisibility ?? this.partnerVisibility,
      partnerSection: partnerSection ?? this.partnerSection,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'intro_section': introduction!.toMap(),
      'category_section': category!.toMap(),
      'product_section': product!.toMap(),
      'counter_section': counterSection!.toMap(),
      'setting': setting!.toMap(),
      'special_offer': specialOffer!.toMap(),
      'template_section': templateSection!.toMap(),
      'trending_section': trendingSection!.toMap(),
      'featured_section': featureSection!.toMap(),
      'popular_trending': popularTrending?.toMap(),
      'why_choose_us': whyChooseUs!.toMap(),
      'partner_visbility': partnerVisibility,
      'partner_section': partnerSection!.toMap(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      introduction: map['intro_section'] != null
          ? IntroductionModel.fromMap(
              map['intro_section'] as Map<String, dynamic>)
          : null,
      category: map['category_section'] != null
          ? CategoryModel.fromMap(
              map['category_section'] as Map<String, dynamic>)
          : null,
      product: map['product_section'] != null
          ? ProductModel.fromMap(map['product_section'] as Map<String, dynamic>)
          : null,
      counterSection: map['counter_section'] != null
          ? CounterModel.fromMap(map['counter_section'] as Map<String, dynamic>)
          : null,
      setting: map['setting'] != null
          ? HomeSetting.fromMap(map['setting'] as Map<String, dynamic>)
          : null,
      specialOffer: map['special_offer'] != null
          ? SpecialOfferModel.fromMap(
              map['special_offer'] as Map<String, dynamic>)
          : null,
      templateSection: map['template_section'] != null
          ? TemplateModel.fromMap(
              map['template_section'] as Map<String, dynamic>)
          : null,
      trendingSection: map['trending_section'] != null
          ? TrendingProductModel.fromMap(
              map['trending_section'] as Map<String, dynamic>)
          : null,
      featureSection: map['featured_section'] != null
          ? ProductModel.fromMap(
              map['featured_section'] as Map<String, dynamic>)
          : null,
      popularTrending: map['popular_trending'] != null
          ? ProductModel.fromMap(
              map['popular_trending'] as Map<String, dynamic>)
          : null,
      whyChooseUs: map['why_choose_us'] != null
          ? ChooseModel.fromMap(map['why_choose_us'] as Map<String, dynamic>)
          : null,
      partnerVisibility: map['partner_visbility'] ?? true,
      partnerSection: map['partner_section'] != null
          ? PartnerModel.fromMap(map['partner_section'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      introduction!,
      category!,
      product!,
      counterSection!,
      setting!,
      specialOffer!,
      templateSection!,
      trendingSection!,
      featureSection!,
      popularTrending!,
      whyChooseUs!,
      partnerVisibility,
      partnerSection!,
    ];
  }
}

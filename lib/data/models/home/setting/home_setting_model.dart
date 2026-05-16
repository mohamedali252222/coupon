import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomeSetting extends Equatable {
  final int id;
  final int maintenanceMode;
  final String logo;
  final String logoTwo;
  final String logoThree;
  final String favicon;
  final String contactEmail;
  final int enableSubscriptionNotify;
  final int enableSaveContactMessage;
  final String textDirection;
  final String timezone;
  final String sidebarLgHeader;
  final String sidebarSmHeader;
  final String topbarPhone;
  final String topbarEmail;
  final String openingTime;
  final String currencyName;
  final String currencyIcon;
  final double currencyRate;
  final String themeOne;
  final String subscriberImage;
  final String subscriptionBg;
  final String home2SubscriptionBg;
  final String home3SubscriptionBg;
  final String blogPageSubscriptionImage;
  final String defaultAvatar;
  final String home2ContactForeground;
  final String home2ContactBackground;
  final String home2ContactCallAs;
  final String home2ContactPhone;
  final String home2ContactAvailable;
  final String home2ContactFormTitle;
  final String home2ContactFormDescription;
  final String howItWorkBackground;
  final String howItWorkForeground;
  final String howItWorkTitle;
  final String howItWorkDescription;
  final String howItWorkItems;
  final int selectedTheme;
  final int blogLeftRight;
  final String themeOneColor;
  final String themeTwoColor;
  final String themeThreeColor;
  final String loginImage;
  final String footerLogo;
  final String footerLogoTwo;
  final String footerLogoThree;
  final String createdAt;
  final String updatedAt;
  final String appVersion;

  const HomeSetting({
    required this.id,
    required this.maintenanceMode,
    required this.logo,
    required this.logoTwo,
    required this.logoThree,
    required this.favicon,
    required this.contactEmail,
    required this.enableSubscriptionNotify,
    required this.enableSaveContactMessage,
    required this.textDirection,
    required this.timezone,
    required this.sidebarLgHeader,
    required this.sidebarSmHeader,
    required this.topbarPhone,
    required this.topbarEmail,
    required this.openingTime,
    required this.currencyName,
    required this.currencyIcon,
    required this.currencyRate,
    required this.themeOne,
    required this.subscriberImage,
    required this.subscriptionBg,
    required this.home2SubscriptionBg,
    required this.home3SubscriptionBg,
    required this.blogPageSubscriptionImage,
    required this.defaultAvatar,
    required this.home2ContactForeground,
    required this.home2ContactBackground,
    required this.home2ContactCallAs,
    required this.home2ContactPhone,
    required this.home2ContactAvailable,
    required this.home2ContactFormTitle,
    required this.home2ContactFormDescription,
    required this.howItWorkBackground,
    required this.howItWorkForeground,
    required this.howItWorkTitle,
    required this.howItWorkDescription,
    required this.howItWorkItems,
    required this.selectedTheme,
    required this.blogLeftRight,
    required this.themeOneColor,
    required this.themeTwoColor,
    required this.themeThreeColor,
    required this.loginImage,
    required this.footerLogo,
    required this.footerLogoTwo,
    required this.footerLogoThree,
    required this.createdAt,
    required this.updatedAt,
    required this.appVersion,
  });

  HomeSetting copyWith({
    int? id,
    int? maintenanceMode,
    String? logo,
    String? logoTwo,
    String? logoThree,
    String? favicon,
    String? contactEmail,
    int? enableSubscriptionNotify,
    int? enableSaveContactMessage,
    String? textDirection,
    String? timezone,
    String? sidebarLgHeader,
    String? sidebarSmHeader,
    String? topbarPhone,
    String? topbarEmail,
    String? openingTime,
    String? currencyName,
    String? currencyIcon,
    double? currencyRate,
    String? themeOne,
    String? subscriberImage,
    String? subscriptionBg,
    String? home2SubscriptionBg,
    String? home3SubscriptionBg,
    String? blogPageSubscriptionImage,
    String? defaultAvatar,
    String? home2ContactForeground,
    String? home2ContactBackground,
    String? home2ContactCallAs,
    String? home2ContactPhone,
    String? home2ContactAvailable,
    String? home2ContactFormTitle,
    String? home2ContactFormDescription,
    String? howItWorkBackground,
    String? howItWorkForeground,
    String? howItWorkTitle,
    String? howItWorkDescription,
    String? howItWorkItems,
    int? selectedTheme,
    int? blogLeftRight,
    String? themeOneColor,
    String? themeTwoColor,
    String? themeThreeColor,
    String? loginImage,
    String? footerLogo,
    String? footerLogoTwo,
    String? footerLogoThree,
    String? createdAt,
    String? updatedAt,
    String? appVersion,
  }) {
    return HomeSetting(
      id: id ?? this.id,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      logo: logo ?? this.logo,
      logoTwo: logoTwo ?? this.logoTwo,
      logoThree: logoThree ?? this.logoThree,
      favicon: favicon ?? this.favicon,
      contactEmail: contactEmail ?? this.contactEmail,
      enableSubscriptionNotify:
          enableSubscriptionNotify ?? this.enableSubscriptionNotify,
      enableSaveContactMessage:
          enableSaveContactMessage ?? this.enableSaveContactMessage,
      textDirection: textDirection ?? this.textDirection,
      timezone: timezone ?? this.timezone,
      sidebarLgHeader: sidebarLgHeader ?? this.sidebarLgHeader,
      sidebarSmHeader: sidebarSmHeader ?? this.sidebarSmHeader,
      topbarPhone: topbarPhone ?? this.topbarPhone,
      topbarEmail: topbarEmail ?? this.topbarEmail,
      openingTime: openingTime ?? this.openingTime,
      currencyName: currencyName ?? this.currencyName,
      currencyIcon: currencyIcon ?? this.currencyIcon,
      currencyRate: currencyRate ?? this.currencyRate,
      themeOne: themeOne ?? this.themeOne,
      subscriberImage: subscriberImage ?? this.subscriberImage,
      subscriptionBg: subscriptionBg ?? this.subscriptionBg,
      home2SubscriptionBg: home2SubscriptionBg ?? this.home2SubscriptionBg,
      home3SubscriptionBg: home3SubscriptionBg ?? this.home3SubscriptionBg,
      blogPageSubscriptionImage:
          blogPageSubscriptionImage ?? this.blogPageSubscriptionImage,
      defaultAvatar: defaultAvatar ?? this.defaultAvatar,
      home2ContactForeground:
          home2ContactForeground ?? this.home2ContactForeground,
      home2ContactBackground:
          home2ContactBackground ?? this.home2ContactBackground,
      home2ContactCallAs: home2ContactCallAs ?? this.home2ContactCallAs,
      home2ContactPhone: home2ContactPhone ?? this.home2ContactPhone,
      home2ContactAvailable:
          home2ContactAvailable ?? this.home2ContactAvailable,
      home2ContactFormTitle:
          home2ContactFormTitle ?? this.home2ContactFormTitle,
      home2ContactFormDescription:
          home2ContactFormDescription ?? this.home2ContactFormDescription,
      howItWorkBackground: howItWorkBackground ?? this.howItWorkBackground,
      howItWorkForeground: howItWorkForeground ?? this.howItWorkForeground,
      howItWorkTitle: howItWorkTitle ?? this.howItWorkTitle,
      howItWorkDescription: howItWorkDescription ?? this.howItWorkDescription,
      howItWorkItems: howItWorkItems ?? this.howItWorkItems,
      selectedTheme: selectedTheme ?? this.selectedTheme,
      blogLeftRight: blogLeftRight ?? this.blogLeftRight,
      themeOneColor: themeOneColor ?? this.themeOneColor,
      themeTwoColor: themeTwoColor ?? this.themeTwoColor,
      themeThreeColor: themeThreeColor ?? this.themeThreeColor,
      loginImage: loginImage ?? this.loginImage,
      footerLogo: footerLogo ?? this.footerLogo,
      footerLogoTwo: footerLogoTwo ?? this.footerLogoTwo,
      footerLogoThree: footerLogoThree ?? this.footerLogoThree,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'maintenance_mode': maintenanceMode,
      'logo': logo,
      'logo_two': logoTwo,
      'logo_three': logoThree,
      'favicon': favicon,
      'contact_email': contactEmail,
      'enable_subscription_notify': enableSubscriptionNotify,
      'enable_save_contact_message': enableSaveContactMessage,
      'text_direction': textDirection,
      'timezone': timezone,
      'sidebar_lg_header': sidebarLgHeader,
      'sidebar_sm_header': sidebarSmHeader,
      'topbar_phone': topbarPhone,
      'topbar_email': topbarEmail,
      'opening_time': openingTime,
      'currency_name': currencyName,
      'currency_icon': currencyIcon,
      'currency_rate': currencyRate,
      'theme_one': themeOne,
      'subscriber_image': subscriberImage,
      'subscription_bg': subscriptionBg,
      'home2_subscription_bg': home2SubscriptionBg,
      'home3_subscription_bg': home3SubscriptionBg,
      'blog_page_subscription_image': blogPageSubscriptionImage,
      'default_avatar': defaultAvatar,
      'home2_contact_foreground': home2ContactForeground,
      'home2_contact_background': home2ContactBackground,
      'home2_contact_call_as': home2ContactCallAs,
      'home2_contact_phone': home2ContactPhone,
      'home2_contact_available': home2ContactAvailable,
      'home2_contact_form_title': home2ContactFormTitle,
      'home2_contact_form_description': home2ContactFormDescription,
      'how_it_work_background': howItWorkBackground,
      'how_it_work_foreground': howItWorkForeground,
      'how_it_work_title': howItWorkTitle,
      'how_it_work_description': howItWorkDescription,
      'how_it_work_items': howItWorkItems,
      'selected_theme': selectedTheme,
      'blog_left_right': blogLeftRight,
      'theme_one_color': themeOneColor,
      'theme_two_color': themeTwoColor,
      'theme_three_color': themeThreeColor,
      'login_image': loginImage,
      'footer_logo': footerLogo,
      'footer_logo_two': footerLogoTwo,
      'footer_logo_three': footerLogoThree,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'app_version': appVersion,
    };
  }

  factory HomeSetting.fromMap(Map<String, dynamic> map) {
    return HomeSetting(
      id: map['id'] ?? 0,
      maintenanceMode: map['maintenance_mode'] != null
          ? int.parse(map['maintenance_mode'].toString())
          : 0,
      logo: map['logo'] ?? '',
      logoTwo: map['logo_two'] ?? '',
      logoThree: map['logo_three'] ?? '',
      favicon: map['favicon'] ?? '',
      contactEmail: map['contact_email'] ?? '',
      enableSubscriptionNotify: map['enable_subscription_notify'] != null
          ? int.parse(map['enable_subscription_notify'].toString())
          : 0,
      enableSaveContactMessage: map['enable_save_contact_message'] != null
          ? int.parse(map['enable_save_contact_message'].toString())
          : 0,
      textDirection: map['text_direction'] ?? '',
      timezone: map['timezone'] ?? '',
      sidebarLgHeader: map['sidebar_lg_header'] ?? '',
      sidebarSmHeader: map['sidebar_sm_header'] ?? '',
      topbarPhone: map['topbar_phone'] ?? '',
      topbarEmail: map['topbar_email'] ?? '',
      openingTime: map['opening_time'] ?? '',
      currencyName: map['currency_name'] ?? '',
      currencyIcon: map['currency_icon'] ?? '',
      currencyRate: map['currency_rate'] != null
          ? double.parse(map['currency_rate'].toString())
          : 0.0,
      themeOne: map['theme_one'] ?? '',
      subscriberImage: map['subscriber_image'] ?? '',
      subscriptionBg: map['subscription_bg'] ?? '',
      home2SubscriptionBg: map['home2_subscription_bg'] ?? '',
      home3SubscriptionBg: map['home3_subscription_bg'] ?? '',
      blogPageSubscriptionImage: map['blog_page_subscription_image'] ?? '',
      defaultAvatar: map['default_avatar'] ?? '',
      home2ContactForeground: map['home2_contact_foreground'] ?? '',
      home2ContactBackground: map['home2_contact_background'] ?? '',
      home2ContactCallAs: map['home2_contact_call_as'] ?? '',
      home2ContactPhone: map['home2_contact_phone'] ?? '',
      home2ContactAvailable: map['home2_contact_available'] ?? '',
      home2ContactFormTitle: map['home2_contact_form_title'] ?? '',
      home2ContactFormDescription: map['home2_contact_form_description'] ?? '',
      howItWorkBackground: map['how_it_work_background'] ?? '',
      howItWorkForeground: map['how_it_work_foreground'] ?? '',
      howItWorkTitle: map['how_it_work_title'] ?? '',
      howItWorkDescription: map['how_it_work_description'] ?? '',
      howItWorkItems: map['how_it_work_items'] ?? '',
      selectedTheme: map['selected_theme'] != null
          ? int.parse(map['selected_theme'].toString())
          : 0,
      blogLeftRight: map['blog_left_right'] != null
          ? int.parse(map['blog_left_right'].toString())
          : 0,
      themeOneColor: map['theme_one_color'] ?? '',
      themeTwoColor: map['theme_two_color'] ?? '',
      themeThreeColor: map['theme_three_color'] ?? '',
      loginImage: map['login_image'] ?? '',
      footerLogo: map['footer_logo'] ?? '',
      footerLogoTwo: map['footer_logo_two'] ?? '',
      footerLogoThree: map['footer_logo_three'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      appVersion: map['app_version'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeSetting.fromJson(String source) =>
      HomeSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      maintenanceMode,
      logo,
      logoTwo,
      logoThree,
      favicon,
      contactEmail,
      enableSubscriptionNotify,
      enableSaveContactMessage,
      textDirection,
      timezone,
      sidebarLgHeader,
      sidebarSmHeader,
      topbarPhone,
      topbarEmail,
      openingTime,
      currencyName,
      currencyIcon,
      currencyRate,
      themeOne,
      subscriberImage,
      subscriptionBg,
      home2SubscriptionBg,
      home3SubscriptionBg,
      blogPageSubscriptionImage,
      defaultAvatar,
      home2ContactForeground,
      home2ContactBackground,
      home2ContactCallAs,
      home2ContactPhone,
      home2ContactAvailable,
      home2ContactFormTitle,
      home2ContactFormDescription,
      howItWorkBackground,
      howItWorkForeground,
      howItWorkTitle,
      howItWorkDescription,
      howItWorkItems,
      selectedTheme,
      blogLeftRight,
      themeOneColor,
      themeTwoColor,
      themeThreeColor,
      loginImage,
      footerLogo,
      footerLogoTwo,
      footerLogoThree,
      createdAt,
      updatedAt,
      appVersion,
    ];
  }
}

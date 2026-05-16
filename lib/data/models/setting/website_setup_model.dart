import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'currencies_model.dart';
import 'language_model.dart';
import 'setting_model.dart';

class WebsiteSetupModel extends Equatable {
  final SettingModel? setting;
  final List<LanguageModel>? languages;
  final List<CurrenciesModel>? currencies;
  final String fileBaseUrl;

  const WebsiteSetupModel({
    this.setting,
    this.languages,
    this.currencies,
    required this.fileBaseUrl,
  });

  WebsiteSetupModel copyWith({
    SettingModel? setting,
    List<LanguageModel>? languages,
    List<CurrenciesModel>? currencies,
    String? fileBaseUrl,
  }) {
    return WebsiteSetupModel(
      setting: setting ?? this.setting,
      languages: languages ?? this.languages,
      currencies: currencies ?? this.currencies,
      fileBaseUrl: fileBaseUrl ?? this.fileBaseUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'setting': setting!.toMap(),
      'languages': languages!.map((x) => x.toMap()).toList(),
      'currencies': currencies!.map((x) => x.toMap()).toList(),
      'file_base_url': fileBaseUrl,
    };
  }

  factory WebsiteSetupModel.fromMap(Map<String, dynamic> map) {
    return WebsiteSetupModel(
      setting: map['setting'] != null
          ? SettingModel.fromMap(map['setting'] as Map<String, dynamic>)
          : null,
      languages: map['languages'] != null
          ? List<LanguageModel>.from(
              (map['languages'] as List<dynamic>).map<LanguageModel>(
                (x) => LanguageModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      currencies: map['currencies'] != null
          ? List<CurrenciesModel>.from(
              (map['currencies'] as List<dynamic>).map<CurrenciesModel>(
                (x) => CurrenciesModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      fileBaseUrl: map['file_base_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WebsiteSetupModel.fromJson(String source) =>
      WebsiteSetupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [setting!, languages!, currencies!, fileBaseUrl];
}

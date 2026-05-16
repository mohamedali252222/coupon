import 'package:alas_mart/logic/cubit/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/models/setting/currencies_model.dart';
import '../../../../data/models/setting/language_model.dart';
import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../logic/bloc/login/login_state_model.dart';
import '../../../../logic/cubit/currency/currency_cubit.dart';
import '../../../../logic/cubit/setting/website_setup_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';

class HomeDropdownButton extends StatefulWidget {
  const HomeDropdownButton({super.key});

  @override
  State<HomeDropdownButton> createState() => _HomeDropdownButtonState();
}

class _HomeDropdownButtonState extends State<HomeDropdownButton> {
  late WebsiteSetupCubit websiteCubit;
  late CurrencyCubit cCubit;
  CurrenciesModel? currency;

  LanguageModel? language;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    websiteCubit = context.read<WebsiteSetupCubit>();
    cCubit = context.read<CurrencyCubit>();
    if (websiteCubit.setting!.currencies!.isNotEmpty) {
      for (int i = 0; i < websiteCubit.setting!.currencies!.length; i++) {
        final item = websiteCubit.setting!.currencies![i];

        if (item.status == 1 && item.isDefault.toLowerCase() == 'yes') {
          currency = item;
          context.read<CurrencyCubit>().addNewCurrency(item);
        }
      }
    }
    if (websiteCubit.setting!.languages!.isNotEmpty) {
      for (int i = 0; i < websiteCubit.setting!.languages!.length; i++) {
        final item = websiteCubit.setting!.languages![i];

        if (item.status == 1 && item.isDefault.toLowerCase() == 'yes') {
          language = item;
          context.read<CurrencyCubit>().addNewLanguage(item);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return Expanded(
      child: BlocConsumer<LoginBloc, LoginStateModel>(
        listener: (context, loginState) {
          if (loginState.languageCode.isNotEmpty) {
            context
                .read<HomeCubit>()
                .getHomeData(); // Fetch new home data on language change
          }
        },
        builder: (context, state) {
          if (state.currencyIcon.isNotEmpty) {
            //debugPrint('state-currency ${state.currencyIcon}');
            currency = websiteCubit.setting!.currencies!
                .where((e) => e.currencyIcon == state.currencyIcon)
                .first;
          } else {
            //debugPrint('empty-state-currency ${state.currencyIcon}');
          }
          if (state.languageCode.isNotEmpty) {
            language = websiteCubit.setting!.languages!
                .where((e) => e.langCode == state.languageCode)
                .first;
            // debugPrint('state-language ${state.languageCode}');
          }
          return Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<CurrenciesModel>(
                    value: currency,
                    hint: const Text('Currencies'),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        // borderSide: BorderSide(width: 1, color: CustomColors.lineColor),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    onTap: () async {
                      Utils.closeKeyBoard(context);
                    },
                    onChanged: (value) {
                      if (value == null) return;
                      cCubit.state.currencies.clear();
                      cCubit.addNewCurrency(value);
                      debugPrint('values $value');
                    },
                    isDense: true,
                    isExpanded: true,
                    items: websiteCubit.setting!.currencies!.isNotEmpty
                        ? websiteCubit.setting!.currencies!
                            .map<DropdownMenuItem<CurrenciesModel>>(
                                (CurrenciesModel value) {
                            return DropdownMenuItem<CurrenciesModel>(
                                value: value,
                                child: Text(
                                  value.currencyName,
                                  style: GoogleFonts.inter(
                                      fontSize: 16.0, color: blackColor),
                                ));
                          }).toList()
                        : []),
              ),
              Expanded(
                child: DropdownButtonFormField<LanguageModel>(
                  value: language,
                  dropdownColor: whiteColor,
                  hint: const CustomText(
                    text: "Language",
                    color: blackColor,
                    fontSize: 16.0,
                  ),
                  isDense: true,
                  isExpanded: true,

                  icon:
                      const Icon(Icons.keyboard_arrow_down, color: blackColor),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    filled: false,
                  ),
                  // onTap: () {
                  //   Utils.closeKeyBoard(context);
                  // },
                  onChanged: (value) {
                    // if (value == null) return;
                    //
                    // debugPrint('Language changed to: ${value.langCode}');
                    //
                    // setState(() {
                    //   loginBloc.add(LoginEventLanguageCode(value.langCode));
                    //   context.read<HomeCubit>().getHomeData();
                    // });
                    if (value == null) return;
                    if (cCubit.state.languages.isNotEmpty) {
                      // print('not-empty-state.currencies ${cCubit.state.currencies}');
                      cCubit.state.languages.clear();
                    }
                    // cCubit.addNewLanguage(value);
                    // loginBloc.add(LoginEventLanguageCode(value.langCode));
                    if (value.langCode != loginBloc.state.languageCode) {
                      cCubit.addNewLanguage(value);
                      loginBloc.add(LoginEventLanguageCode(cCubit.state.languages.first.langCode));
                      websiteCubit.getWebsiteSetupData();
                    }
                  },

                  items: websiteCubit.setting!.languages!
                      .map<DropdownMenuItem<LanguageModel>>(
                          (LanguageModel value) =>
                              DropdownMenuItem<LanguageModel>(
                                  value: value,
                                  child: CustomText(
                                    text: value.langName,
                                    color: blackColor,
                                    fontSize: 16.0,
                                  )))
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

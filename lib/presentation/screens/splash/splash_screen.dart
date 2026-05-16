import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/internet_status/internet_status_bloc.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/currency/currency_cubit.dart';
import '../../../logic/cubit/setting/website_setup_cubit.dart';
import '../../routes/routes_name.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_image.dart';
import '../../widget/exit_from_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  initializeController() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    initializeController();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final loginBloc = context.read<LoginBloc>();
    final cCubit = context.read<CurrencyCubit>();
    final settingCubit = context.read<WebsiteSetupCubit>();
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const ExitFromApp(),
        );
        return true;
      },
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<InternetStatusBloc, InternetStatusState>(
              listener: (context, state) {
                if (state is InternetStatusBackState) {
                  // Utils.showSnackBar(context, state.message);
                  settingCubit.getWebsiteSetupData();
                } else if (state is InternetStatusLostState) {
                  print('no internet');
                  // Utils.showSnackBar(context, state.message);
                }
              },
            ),
            BlocListener<WebsiteSetupCubit, WebsiteSetupState>(
              listener: (context, state) {
                if (state is WebsiteSetupLoaded) {
                  final code = state.websiteSetup;
                  if (code.setting != null) {
                    if (code.languages!.isNotEmpty) {
                      for (int i = 0; i < code.languages!.length; i++) {
                        if (code.languages![i].isDefault == 'Yes') {
                          debugPrint('dynamically-languageCode-assign');
                          final langCode = code.languages![i].langCode;
                          loginBloc.add(LoginEventLanguageCode(langCode));
                          debugPrint('dynamic-languageCode $langCode');
                        }
                      }
                    }
                  } else {
                    debugPrint('default-languageCode-assign');
                    loginBloc.add(const LoginEventLanguageCode('en'));
                    debugPrint(
                        'default-languageCode ${loginBloc.state.languageCode}');
                  }
                  if (cCubit.state.currencies.isNotEmpty) {
                    cCubit.state.currencies.clear();
                  }
                  if (settingCubit.setting != null &&
                      settingCubit.setting!.currencies!.isNotEmpty) {
                    final currency = settingCubit.setting!.currencies!;
                    for (int i = 0; i < currency.length; i++) {
                      if (currency[i].isDefault.toLowerCase() == 'yes' &&
                          currency[i].status == 1) {
                        cCubit.addNewCurrency(currency[i]);
                      }
                    }
                  }

                  if (loginBloc.isLoggedIn) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteNames.mainScreen, (route) => false);
                  } else if (settingCubit.showOnBoarding) {
                    Navigator.pushNamedAndRemoveUntil(context,
                        RouteNames.authenticationScreen, (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteNames.onBoardingScreen, (route) => false);
                  }
                } else if (state is WebsiteSetupLoading) {
                  print('loading...');
                } else if (state is WebsiteSetupError) {
                  print('errors ${state.message}');
                  Utils.errorSnackBar(context, state.message);
                }
              },
            ),
          ],
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: CustomImage(
              path: KImages.splashBg,
              fit: BoxFit.cover,
              height: size.height,
              width: size.width,
            ),
          ),
        ),
      ),
    );
  }
}

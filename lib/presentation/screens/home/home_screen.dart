import 'package:alas_mart/presentation/widget/page_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/dummy_data/dummy_data.dart';
import '../../../data/models/home/home_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/bloc/login/login_state_model.dart';
import '../../../logic/cubit/home/home_cubit.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';
import 'component/best_sell_theme_horizontal_view.dart';
import 'component/category_widget.dart';
import 'component/custom_offer_widget.dart';
import 'component/feature_theme_horizontal_view.dart';
import 'component/home_app_bar.dart';
import 'component/top_offer_section.dart';
import 'component/trending_horizontal_product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final homeCubit = context.read<HomeCubit>();
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(
      backgroundColor: homeBgColor,
      body: PageRefresh(
        onRefresh: () async {
          homeCubit.getHomeData();
        },
        child: BlocListener<LoginBloc, LoginStateModel>(
          listener: (context, state) {
            final logout = state.loginState;
            if (logout is LoginStateLogoutLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (logout is LoginStateLogoutError) {
                Utils.errorSnackBar(context, logout.message);
              } else if (logout is LoginStateLogoutLoaded) {
                Utils.showSnackBar(context, logout.message);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.authenticationScreen, (route) => false);
              }
            }
          },
          child: BlocConsumer<HomeCubit, LanguageCodeState>(
            listener: (context, state) {
              final home = state.homeState;
              if (home is HomeStateError) {
                if (home.statusCode == 401) {
                  loginBloc.add(const LoginEventLogout());
                }
        
                if (home.statusCode == 503 || homeCubit.homeModel == null) {
                  debugPrint('homeModel null OR 503');
                  homeCubit.getHomeData();
                }
              }
            },
            builder: (context, state) {
              final home = state.homeState;
              if (home is HomeStateLoading) {
                //return const LoadingWidget();
                return const Center(child: LoaderCircle());
              } else if (home is HomeStateError) {
                if (home.statusCode == 401) {
                } else if (home.statusCode == 503 ||
                    homeCubit.homeModel != null) {
                  return LoadedHomeWidget(homeModel: homeCubit.homeModel!);
                } else {
                  return const FetchErrorText(text: 'Network problem');
                }
                return FetchErrorText(text: home.message);
              } else if (home is HomeStateLoaded) {
                return LoadedHomeWidget(homeModel: home.homeModel);
              }
              if (homeCubit.homeModel != null) {
                return LoadedHomeWidget(homeModel: homeCubit.homeModel!);
              } else {
                return const FetchErrorText(text: 'Something went wrong!');
              }
            },
          ),
        ),
      ),
    );
  }
}

class LoadedHomeWidget extends StatelessWidget {
  const LoadedHomeWidget({super.key, required this.homeModel});

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    print('homeee ${homeModel.partnerSection!.partners!.length}');
    final loginBloc = context.read<LoginBloc>();
    print('user-name ${loginBloc.userInformation!.user!.name}');
    return CustomScrollView(
      slivers: [
        const HomeAppBar(),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              TopOfferSection(introduction: homeModel.introduction!),
              sectionSpace,
              CategoryWidget(categories: homeModel.category!),
              sectionSpace,
              BestSellThemeHorizontalView(
                onTap: () => Navigator.pushNamed(
                    context, RouteNames.bestSellingThemeScreen),
              ),
              // sectionSpace,
              Utils.verticalSpace(30.0),
              const OfferWidget(
                  headingText: offerText, buttonText: 'Go to Offer Page'),
              sectionSpace,
              const TrendingHorizontalProduct(),
              // sectionSpace,
              // const OfferWidget(headingText: offerText2, buttonText: 'Become an Author'),
              //sectionSpace,
              Utils.verticalSpace(15.0),
              FeatureThemeHorizontalView(
                  title: 'Feature Themes',
                  onTap: () => Navigator.pushNamed(
                      context, RouteNames.bestSellingThemeScreen)),
              sectionSpace,
            ],
          ),
        ),
      ],
    );
  }
}

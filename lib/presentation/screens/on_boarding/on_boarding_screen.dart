import 'package:alas_mart/state_packages_name.dart';
import 'package:flutter/material.dart';

import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';
import 'data/on_boarding_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late int _numPages;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _numPages = data.length;
    _pageController = PageController(initialPage: _currentPage);
  }

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 500) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(-0.80, -0.60),
                          end: Alignment(0.80, 0.6),
                          colors: gradientColors)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildSkipButton(),
                      _buildImagesSlider(),
                      Utils.verticalSpace(size.height * 0.06),
                      _buildContent(),
                      Utils.verticalSpace(24.0),
                      _buildDotIndicator(),
                      Utils.verticalSpace(40.0),
                      _gradientButton(),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(-0.80, -0.60),
                          end: Alignment(0.80, 0.6),
                          colors: gradientColors)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildSkipButton(),
                      _buildImagesSlider(),
                      Utils.verticalSpace(size.height * 0.04),
                      _buildContent(),
                      Utils.verticalSpace(24.0),
                      _buildDotIndicator(),
                      Utils.verticalSpace(40.0),
                      _gradientButton(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildImagesSlider() {
    return Container(
      height: size.height * 0.4,
      padding: Utils.all(value: 2.0),
      child: PageView(
        physics: const ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: data.map((e) => CustomImage(path: e.image)).toList(),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: Utils.symmetric(h: 30.0),
      child: AnimatedSwitcher(
        duration: kDuration,
        transitionBuilder: (Widget child, Animation<double> anim) {
          return FadeTransition(opacity: anim, child: child);
        },
        child: getContent(),
      ),
    );
  }

  Widget getContent() {
    final item = data[_currentPage];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      key: ValueKey('$_currentPage'),
      children: [
        //Utils.convertedText(context, item.title),
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 500) {
            return CustomText(
                text: item.title,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                color: whiteColor,
                height: 1.6);
          } else {
            return CustomText(
              text: item.title,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              color: whiteColor,
            );
          }
        }),
        // Utils.verticalSpace(16.0),
        // CustomText(
        //   text: item.subTitle,
        //   textAlign: TextAlign.center,
        //   color: grayColor,
        //   height: 1.6,
        // ),
      ],
    );
  }

  Widget _buildDotIndicator() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 500) {
        return CustomText(
          text: '${_currentPage + 1}/$_numPages',
          color: whiteColor,
          fontSize: 20.0,
        );
      } else {
        return CustomText(
          text: '${_currentPage + 1}/$_numPages',
          color: whiteColor,
          fontSize: 12.0,
        );
      }
    });
  }

  Widget _buildSkipButton() {
    return GestureDetector(
      onTap: () {
        context.read<WebsiteSetupCubit>().cacheOnBoarding();
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.authenticationScreen, (route) => false);
      },
      child: Container(
        alignment: Alignment.centerRight,
        margin: Utils.only(right: 20.0),
        child: const CustomText(
          text: 'Skip',
          fontWeight: FontWeight.w400,
          fontSize: 18.0,
          color: whiteColor,
        ),
      ),
    );
  }

  Widget _gradientButton() {
    return GestureDetector(
      onTap: () {
        if (_currentPage == data.length - 1) {
          context.read<WebsiteSetupCubit>().cacheOnBoarding();
          Navigator.pushNamedAndRemoveUntil(
              context, RouteNames.authenticationScreen, (route) => false);
        } else {
          _pageController.nextPage(
              duration: kDuration, curve: Curves.easeInOut);
        }
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 500) {
          return Container(
            // width: 108,
            // height: 48,
            padding: Utils.symmetric(v: 10.0),
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.53, -0.85),
                end: Alignment(-0.53, 0.85),
                colors: [Color(0xFFF9B546), Color(0xFFF4642C)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'Next',
                  color: blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
                Padding(
                  padding: Utils.only(top: 2.0, left: 8.0),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 24.0,
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            //width: 108,
            //height: 48,
            padding: Utils.symmetric(v: 5.0),
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.53, -0.85),
                end: Alignment(-0.53, 0.85),
                colors: [Color(0xFFF9B546), Color(0xFFF4642C)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'Next',
                  color: blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                ),
                Padding(
                  padding: Utils.only(top: 2.0, left: 8.0),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 24.0,
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}

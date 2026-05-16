import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/home/home_cubit.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_sliver_app_bar.dart';
import '../../../widget/custom_text.dart';
import 'trending_horizontal_product.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final trending = homeCubit.homeModel!.trendingSection!;
    return Scaffold(
      backgroundColor: homeBgColor.withOpacity(0.99),
      body: CustomScrollView(
        slivers: [
          // CustomSliverAppBar(
          //   title: 'Trending Themes',
          //   isGradientBg: true,
          //   iconColor: whiteColor,
          //   height: 160.0,
          //   child: _trendingItem(),
          // ),
          const CustomSliverAppBar(
            title: 'Trending Themes',
            iconColor: whiteColor,
            isGradientBg: true,
          ),
          SliverToBoxAdapter(child: Utils.verticalSpace(10.0)),
          SliverList.list(
            children: List.generate(
              trending.trendingProducts!.length,
              (index) {
                final items = trending.trendingProducts![index];
                return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteNames.detailScreen,
                        arguments: items.slug),
                    child: SingleTrendingCard(theme: items));
              },
            ),
          ),
          SliverToBoxAdapter(child: Utils.verticalSpace(30.0))
        ],
      ),
    );
  }

  Widget _trendingItem() {
    return Padding(
      padding: Utils.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          trendingItem.length,
          (index) {
            return GestureDetector(
              onTap: () => setState(() => currentIndex = index),
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                decoration: BoxDecoration(
                    color: currentIndex == index ? primaryColor : whiteColor,
                    borderRadius: Utils.borderRadius(r: 6.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x28000000),
                        blurRadius: 44,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ]),
                padding: Utils.symmetric(v: 14.0, h: 22.0),
                child: CustomText(
                  text: trendingItem[index],
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: currentIndex == index ? whiteColor : textColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<String> trendingItem = ['Popular', 'Trending', 'New Items'];

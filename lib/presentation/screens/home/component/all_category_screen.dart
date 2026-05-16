import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../logic/cubit/home/home_cubit.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_sliver_app_bar.dart';
import 'single_category_card.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final category = homeCubit.homeModel!.category!.categories!;
    return Scaffold(
      backgroundColor: homeBgColor.withOpacity(1.0),
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
            title: 'All Category',
            iconColor: whiteColor,
            isGradientBg: true,
          ),
          SliverPadding(
            padding: Utils.symmetric(h: 0.0, v: 16.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = category[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, RouteNames.filterScreen,
                      arguments: item.slug),
                  child: SingleCategoryCard(
                    icon: RemoteUrls.imageUrl(item.icon),
                    name: item.catLangFrontEndModel!.name,
                    height: 100.0,
                    width: 100.0,
                  ),
                );
              }, childCount: category.length, addAutomaticKeepAlives: true),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.94,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

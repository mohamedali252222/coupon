import 'package:alas_mart/data/data_provider/remote_url.dart';
import 'package:alas_mart/data/models/home/category/home_category_model.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import 'heading.dart';
import 'single_category_card.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.categories});

  final CategoryModel categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Heading(
          title1: 'Categories',
          onTap: () =>
              Navigator.pushNamed(context, RouteNames.allCategoryScreen),
        ),
        itemSpace,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              categories.categories!.length > 5
                  ? 5
                  : categories.categories!.length,
              (index) {
                final item = categories.categories![index];
                return Padding(
                  padding: Utils.only(
                      left: index == 0 ? 20.0 : 0.0,
                      right: index == categories.categories!.length - 1
                          ? 20.0
                          : 0.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, RouteNames.filterScreen,
                        arguments: item.slug),
                    child: SingleCategoryCard(
                      icon: RemoteUrls.imageUrl(item.icon),
                      name: item.catLangFrontEndModel!.name,
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

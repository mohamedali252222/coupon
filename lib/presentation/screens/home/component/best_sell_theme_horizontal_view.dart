import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubit/home/home_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import 'heading.dart';
import 'single_product_card.dart';

class BestSellThemeHorizontalView extends StatelessWidget {
  const BestSellThemeHorizontalView({
    super.key,
    this.title = 'Best Selling Theme',
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final product = homeCubit.homeModel!.product!.products!;
    return Column(
      children: [
        Heading(
          title1: title,
          onTap: onTap,
        ),
        itemSpace,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Row(
            children: List.generate(
              product.length > 5 ? 5 : product.length,
              (index) => Padding(
                padding: Utils.only(
                    left: index == 0 ? 10.0 : 0.0,
                    right: index == product.length - 1 ? 10.0 : 0.0),
                child: SingleProductCard(
                  theme: product[index],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

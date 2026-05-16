import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/login/login_bloc.dart';
import '../../logic/cubit/add_to_cart/add_to_cart_cubit.dart';
import '../../logic/cubit/language_code_state.dart';
import '../routes/routes_name.dart';
import '../utils/constraints.dart';
import 'custom_badges.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final addToCartCubit = context.read<AddToCartCubit>();
    final loginBloc = context.read<LoginBloc>();
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteNames.cartScreen),
      child: BlocBuilder<AddToCartCubit, LanguageCodeState>(
        builder: (context, state) {
          final addToCart = state.addToCartState;
          if (addToCart is TotalCartItem) {
            return CustomBadges(
              title: addToCart.value.toString(),
              icon: Icons.shopping_cart,
              iconColor: blackColor,
            );
          }
          return CustomBadges(
            title: addToCartCubit.totalCart.toString(),
            icon: Icons.shopping_cart,
            iconColor: blackColor,
          );
        },
      ),
    );
  }
}

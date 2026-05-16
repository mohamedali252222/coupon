import 'package:alas_mart/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubit/cart/cart_cubit.dart';
import '../../../logic/cubit/home/home_cubit.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../../widget/exit_from_app.dart';
import '../dashboard/dashboard_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../wishlist/wishlist_screen.dart';
import 'component/bottom_navigation_bar.dart';
import 'component/main_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _homeController = MainController();
  late List<Widget> screenList;

  @override
  void initState() {
    super.initState();
    screenList = [
      const HomeScreen(),
      const WishlistScreen(isVisibleBackButton: false),
      const DashboardScreen(),
      const ProfileScreen(),
    ];
    context.read<ProfileCubit>().getUserProfile();
    context.read<WishlistCubit>().getWistItems();
    context.read<CartCubit>().getCartProduct();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    print('check-price ${Utils.formatPrice(context, '10')}');
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
        body: StreamBuilder<int>(
          initialData: 0,
          stream: _homeController.naveListener.stream,
          builder: (context, AsyncSnapshot<int> snapshot) {
            int item = snapshot.data ?? 0;
            return screenList[item];
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeCubit, LanguageCodeState>(
          builder: (context, state) {
            final home = state.homeState;
            if (home is HomeStateLoaded) {
              return const MyBottomNavigationBar();
            }
            if (homeCubit.homeModel != null) {
              return const MyBottomNavigationBar();
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

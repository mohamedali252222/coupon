import 'package:alas_mart/presentation/utils/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/k_images.dart';
import 'main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    return Container(
      height: 110,
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 36,
              offset: Offset(0, 0),
              spreadRadius: 5,
            )
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: StreamBuilder(
          initialData: 0,
          stream: controller.naveListener.stream,
          builder: (_, AsyncSnapshot<int> index) {
            int selectedIndex = index.data ?? 0;
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  tooltip: 'الرئيسية',
                  icon: _navIcon(KImages.home),
                  activeIcon: _navIcon(KImages.homeActive),
                  label: "الرئيسية",
                ),
                BottomNavigationBarItem(
                  tooltip: "المفضلة",
                  icon: _navIcon(KImages.wishlist),
                  activeIcon: _navIcon(KImages.wishlistActive),
                  label: 'المفضلة',
                ),
                BottomNavigationBarItem(
                  tooltip: 'المزيد',
                  icon: _navIcon(KImages.more),
                  activeIcon: _navIcon(KImages.moreActive),
                  label: 'المزيد',
                ),
                BottomNavigationBarItem(
                  tooltip: 'حسابي',
                  activeIcon: _navIcon(KImages.profileActive),
                  icon: _navIcon(KImages.profile),
                  label: 'حسابي',
                ),
              ],
              // type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              onTap: (int index) {
                controller.naveListener.sink.add(index);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _navIcon(String path) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SvgPicture.asset(path));
}

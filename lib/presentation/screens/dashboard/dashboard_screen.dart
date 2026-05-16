import 'package:flutter/material.dart';

import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';
import '../main_screen/component/main_controller.dart';
import 'component/dashboard_items.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: scaffoldBgColor,
            automaticallyImplyLeading: false,
            title: CustomText(
              text: 'Dashboard',
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              color: blackColor,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, RouteNames.uploadProductTypeScreen),
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Utils.hPadding(size: 12.0)),
                padding: EdgeInsets.symmetric(
                    horizontal: Utils.hPadding(size: 16.0),
                    vertical: Utils.vPadding(size: 22.0)),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: whiteColor,
                      child: CustomImage(
                          path: KImages.uploadIcon, color: blackColor),
                    ),
                    Utils.horizontalSpace(10.0),
                    const CustomText(
                      text: 'Upload Your Product',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: whiteColor,
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: Utils.hPadding(size: 12.0),
                vertical: Utils.vPadding()),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate([
                DashboardItem(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.overviewScreen),
                  title: 'Overview',
                  icon: KImages.description,
                ),
                DashboardItem(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.portfolioScreen),
                  title: 'Portfolio',
                  icon: KImages.dashboardIcon02,
                ),
                DashboardItem(
                  onTap: () => Navigator.pushNamed(
                      context, RouteNames.downloadedFileScreen),
                  title: 'Downloaded File',
                  icon: KImages.dashboardIcon03,
                ),
                DashboardItem(
                  onTap: () {
                    // Navigator.pushNamed(context, RouteNames.wishlistScreen,
                    //     arguments: true);
                    final controller = MainController();
                    controller.naveListener.add(1);
                  },
                  title: 'Collections',
                  icon: KImages.dashboardIcon04,
                ),
                DashboardItem(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteNames.withdrawScreen),
                  title: 'Withdraws',
                  icon: KImages.dashboardIcon05,
                ),
              ]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                mainAxisExtent: Utils.vSize(size.height * 0.16),
              ),
            ),
          )
        ],
      ),
    );
  }
}

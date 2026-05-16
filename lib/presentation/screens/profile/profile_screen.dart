import 'package:alas_mart/logic/cubit/profile/profile_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/bloc/login/login_state_model.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/setting/website_setup_cubit.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/action_button.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';
import '../../widget/feedback_dialog.dart';
import '../authentication/component/custom_authentication_widget.dart';
import 'component/profile_items.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomAuthenticationWidget(
        height: Utils.vSize(size.height * 0.2),
        topChild: const ProfileAppBar(),
        isShowBackButton: false,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: Utils.only(bottom: size.height * 0.28, top: 20.0),
          shrinkWrap: true,
          children: [
            ProfileItem(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.allCategoryScreen);
              },
              title: 'All Category',
              icon: KImages.profileIcon01,
            ),
            // ProfileItem(
            //   onTap: () {
            //     // Navigator.pushNamed(
            //     //     context, RouteNames.wishListScreen,
            //     //     arguments: true);
            //     final controller = MainController();
            //     controller.naveListener.add(1);
            //   },
            //   title: 'Wishlist',
            //   icon: KImages.profileIcon03,
            // ),
            ProfileItem(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.changePasswordScreen),
              title: 'Change Password',
              icon: KImages.profileIcon06,
            ),
            ProfileItem(
              onTap: () => Navigator.pushNamed(
                  context, RouteNames.termsAndConditionScreen),
              title: 'Teams and Condition',
              icon: KImages.profileIcon04,
            ),
            ProfileItem(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.privacyPolicyScreen),
              title: 'Privacy Policy',
              icon: KImages.profileIcon05,
            ),
            ProfileItem(
              onTap: () => Navigator.pushNamed(context, RouteNames.faqScreen),
              title: 'FAQ',
              icon: KImages.profileIcon07,
            ),
            ProfileItem(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.aboutUsScreen),
              title: 'About Us',
              icon: KImages.profileIcon08,
            ),
            ProfileItem(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.contactUsScreen),
              title: 'Contact Us',
              icon: KImages.profileIcon09,
            ),
            ProfileItem(
              onTap: () {},
              title: 'App Info',
              icon: KImages.profileIcon10,
              isVersion: true,
            ),
            ProfileItem(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const LogoutDialog(),
                );
              },
              title: 'Sign Out',
              icon: KImages.profileIcon11,
              isUnderline: false,
            ),
            Utils.verticalSpace(30.0),
          ],
        ),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return BlocListener<LoginBloc, LoginStateModel>(
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
      child: FeedBackDialog(
        image: KImages.deleteIcon,
        message: 'Are you sure',
        child: Column(
          children: [
            const CustomText(
              text: 'You want to Logout?',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: grayColor,
            ),
            Utils.verticalSpace(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  title: 'Yes',
                  onTap: () => loginBloc.add(const LoginEventLogout()),
                  color: blackColor,
                  textColor: whiteColor,
                ),
                Utils.horizontalSpace(18.0),
                ActionButton(
                  title: 'Cancel',
                  onTap: () => Navigator.of(context).pop(),
                  color: primaryColor,
                  textColor: whiteColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAppBar extends StatefulWidget {
  const ProfileAppBar({super.key});

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  String? image;

  String? name;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final loginBloc = context.read<LoginBloc>();
    final settingCubit = context.read<WebsiteSetupCubit>().setting!.setting!;
    final profileCubit = context.read<ProfileCubit>();
    final user = loginBloc.userInformation!.user!;
    return Positioned(
      top: Utils.vSize(size.height * 0.08),
      child: Container(
        width: size.width,
        margin: Utils.only(left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomImage(
                  path: RemoteUrls.imageUrl(settingCubit.logo),
                  color: whiteColor),
            ),
            Utils.horizontalSpace(14.0),
            //const CustomImage(path: KImages.appNameIcon),
            BlocConsumer<ProfileCubit, ProfileStateModel>(
              listener: (context, state) {
                final profile = state.profileState;
                if (profile is ProfileStateUpdated) {
                  debugPrint('profile-updated-setting');
                  profileCubit.getUserProfile();
                }
              },
              builder: (context, state) {
                if (profileCubit.userModel != null) {
                  image = profileCubit.userModel!.image.isNotEmpty
                      ? RemoteUrls.imageUrl(profileCubit.userModel!.image)
                      : RemoteUrls.imageUrl(settingCubit.defaultAvatar);
                  name = profileCubit.userModel!.name;
                } else {
                  image = user.image.isNotEmpty
                      ? RemoteUrls.imageUrl(user.image)
                      : RemoteUrls.imageUrl(settingCubit.defaultAvatar);
                  name = user.name;
                }
                return Row(
                  children: [
                    CustomText(
                      text: name!,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: whiteColor,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (loginBloc.userInformation == null) {
                          Utils.showSnackBar(context, 'Login first');
                        } else {
                          if (profileCubit.userModel != null) {
                            Navigator.pushNamed(
                                context, RouteNames.updateProfileScreen,
                                arguments: profileCubit.userModel!);
                          } else {
                            Utils.showSnackBar(context, 'Your session expired');
                          }
                        }
                      },
                      child: Container(
                        height: Utils.vSize(52.0),
                        width: Utils.vSize(52.0),
                        margin: Utils.only(right: 40.0, left: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: whiteColor, width: 1.5),
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: Utils.borderRadius(r: 30.0),
                          child: CustomImage(
                            path: image,
                            // path: KImages.userPicture,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

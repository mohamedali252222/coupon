import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/models/auth_response/user_model.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../../logic/cubit/setting/website_setup_cubit.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';
import '../authentication/component/custom_authentication_widget.dart';

class OverViewScreen extends StatelessWidget {
  const OverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    profileCubit.getUserProfile();
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<ProfileCubit, ProfileStateModel>(
        listener: (context, state) {
          final profile = state.profileState;
          if (profile is ProfileStateUpdated) {
            profileCubit.getUserProfile();
          }
        },
        builder: (context, state) {
          final profile = state.profileState;
          if (profile is ProfileStateLoading) {
            return const Center(child: LoaderCircle());
          } else if (profile is ProfileStateError) {
            if (profile.statusCode == 503) {
              if (profileCubit.userModel != null) {
                return LoadedProfileWidget(userModel: profileCubit.userModel!);
              } else {
                return const FetchErrorText(text: 'Network problem');
              }
            }
            return const FetchErrorText(text: 'Something goes wrong!');
          } else if (profile is ProfileStateLoaded) {
            return LoadedProfileWidget(userModel: profile.userModel);
          }
          if (profileCubit.userModel != null) {
            return LoadedProfileWidget(userModel: profileCubit.userModel!);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

final images = [
  KImages.facebook,
  KImages.linkedin,
  KImages.pinterest,
  KImages.twitter,
];

class LoadedProfileWidget extends StatelessWidget {
  const LoadedProfileWidget({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    debugPrint('namee ${userModel.name}');
    final settingCubit =
        context.read<WebsiteSetupCubit>().setting!.setting!.defaultAvatar;
    final image = userModel.image.isNotEmpty ? userModel.image : settingCubit;
    return CustomAuthenticationWidget(
      height: size.height * 0.18,
      isShowBackButton: false,
      topChild: _buildOverviewAppBar(size, context),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: Utils.only(bottom: size.height * 0.2),
        children: [
          _buildImage(image),
          Container(
            padding: Utils.all(value: 30.0),
            margin: Utils.symmetric(h: 12.0, v: 16.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: Utils.borderRadius(),
            ),
            child: Column(
              children: [
                CustomText(
                  text: userModel.name,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
                Utils.verticalSpace(6.0),
                CustomText(
                  text: userModel.designation,
                  fontSize: 16.0,
                  color: grayColor,
                  textAlign: TextAlign.center,
                ),
                Utils.verticalSpace(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => Padding(
                      padding: Utils.only(right: 10.0),
                      child: CustomImage(
                        path: images[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const CustomText(
            text: 'About Me',
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
          Utils.verticalSpace(6.0),
          ReadMoreText(Utils.htmlTextConverter(userModel.aboutMe),
              style: GoogleFonts.rubik(color: grayColor, fontSize: 14.0)),
          Utils.verticalSpace(24.0),
          const CustomText(
            text: 'My Skill',
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
          Utils.verticalSpace(6.0),
          // const CustomText(
          //   text: skillDes,
          //   fontSize: 14.0,
          //   color: grayColor,
          //   height: 1.6,
          //   maxLine: 10,
          // ),
          ReadMoreText(Utils.htmlTextConverter(userModel.mySkill),
              style: GoogleFonts.rubik(color: grayColor, fontSize: 14.0)),
          // Utils.verticalSpace(14.0),
          // ...List.generate(
          //   skills.length,
          //   (index) => Padding(
          //     padding: Utils.only(bottom: 6.0, left: 6.0),
          //     child: Row(
          //       children: [
          //         Padding(
          //             padding: Utils.only(top: 2.0),
          //             child: const Icon(Icons.check_circle_outline_outlined,
          //                 color: primaryColor)),
          //         Utils.horizontalSpace(6.0),
          //         CustomText(text: skills[index]),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildImage(String image) {
    return Container(
      height: Utils.vSize(120.0),
      width: Utils.vSize(120.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC2DDFF), width: 4.0),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: Utils.borderRadius(r: 50.0),
        child: CustomImage(
          //path: KImages.userPicture,
          path: RemoteUrls.imageUrl(image),
          height: Utils.vSize(110.0),
          width: Utils.hSize(100.0),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildOverviewAppBar(Size size, BuildContext context) {
    return Positioned(
      top: Utils.vSize(size.height * 0.06),
      child: Container(
        width: size.width,
        margin: Utils.only(left: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomAppBar(
              title: 'Overview',
              textColor: whiteColor,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, RouteNames.updateProfileScreen,
                  arguments: userModel),
              child: Container(
                padding: Utils.symmetric(h: 12.0, v: 12.0),
                margin: Utils.only(right: 0.0),
                decoration: BoxDecoration(
                  borderRadius: Utils.borderRadius(r: 6.0),
                  gradient: const LinearGradient(
                    begin: Alignment(0.53, -0.85),
                    end: Alignment(-0.53, 0.85),
                    colors: [Color(0xFFF9B546), Color(0xFFF4642C)],
                  ),
                ),
                child: const CustomText(
                  text: 'Edit Profile',
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

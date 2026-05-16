import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/auth_response/user_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/profile/profile_cubit.dart';
import '../../../logic/cubit/profile/profile_state_model.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/primary_button.dart';
import '../authentication/component/custom_authentication_widget.dart';
import 'component/update_profile_form.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {




  @override
  void initState() {
    //initExistingData();
    super.initState();
  }

  void initExistingData() {
    final profile = context.read<ProfileCubit>();
    final user = widget.userModel;
    debugPrint('country: ${user.country}');
    profile.nameChange(user.name);
    profile.phoneChange(user.phone);
    profile.addressChange(user.address);
    profile.designationChange(user.designation);
    profile.aboutMeChange(user.aboutMe);
    profile.mySkillChange(user.mySkill);
    profile.facebookChange(user.facebook);
    profile.twitterChange(user.twitter);
    profile.linkedinChange(user.linkedin);
    profile.dribbbleChange(user.dribbble);
    profile.pinterestChange(user.pinterest);
    profile.countryChange(user.country);
    profile.stateChange(user.state);
    profile.cityChange(user.city);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final profileCubit = context.read<ProfileCubit>();
    final loginBloc = context.read<LoginBloc>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: BlocListener<ProfileCubit, ProfileStateModel>(
        listener: (context, state) {
          final profile = state.profileState;
          if (profile is ProfileStateUpdating) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (profile is ProfileStateUpdateError) {

              if (profile.statusCode == 401) {
                loginBloc.add(const LoginEventLogout());
              } else {
                Utils.errorSnackBar(context, profile.message);
              }

            } else if (profile is ProfileStateUpdated) {
              Utils.showSnackBar(context, profile.message);
              //Navigator.maybePop(context, true);
            }
          }
        },
        listenWhen: (previous, current) => previous != current,
        child: CustomAuthenticationWidget(
          height: size.height * 0.18,
          isShowBackButton: false,
          topChild: _buildUpdateProfileAppBar(size),
          child: UpdateProfileForm(user: profileCubit.userModel!),
        ),
      ),
      bottomNavigationBar: Container(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(
            text: 'Update Profile',
            onPressed: () {
              Utils.closeKeyBoard(context);
              profileCubit.updateUserInfo();
            }),
      ),
    );
  }

  Widget _buildUpdateProfileAppBar(Size size) {
    return Positioned(
      top: Utils.vSize(size.height * 0.06),
      child: Container(
        width: size.width,
        margin: Utils.only(left: 20.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAppBar(
              title: 'Update Profile',
              textColor: whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}

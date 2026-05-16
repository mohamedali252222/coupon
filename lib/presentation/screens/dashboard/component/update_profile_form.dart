import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/auth_response/user_model.dart';
import '../../../../logic/cubit/profile/profile_cubit.dart';
import '../../../../logic/cubit/profile/profile_state_model.dart';
import '../../../../logic/cubit/setting/website_setup_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/error_text.dart';

class UpdateProfileForm extends StatelessWidget {
  const UpdateProfileForm({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final profileCubit = context.read<ProfileCubit>();
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: Utils.only(bottom: size.height * 0.3),
      children: [
        _buildImage(context),
        CustomFormWidget(
          label: 'Name',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              final profile = state.profileState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'your name'),
                    keyboardType: TextInputType.name,
                    initialValue: user.name,
                    onChanged: (String text) => profileCubit.nameChange(text),
                  ),
                  if (profile is ProfileStateFormValidate) ...[
                    if (profile.errors.name.isNotEmpty)
                      ErrorText(text: profile.errors.name.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Designation',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              final profile = state.profileState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'designation'),
                    keyboardType: TextInputType.text,
                    initialValue: user.designation,
                    onChanged: (String text) =>
                        profileCubit.designationChange(text),
                  ),
                  if (profile is ProfileStateFormValidate) ...[
                    if (profile.errors.designation.isNotEmpty)
                      ErrorText(text: profile.errors.designation.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Phone',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              final profile = state.profileState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'your phone number'),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny('a'),
                    ],
                    initialValue: user.phone,
                    onChanged: (String text) => profileCubit.phoneChange(text),
                  ),
                  if (profile is ProfileStateFormValidate) ...[
                    if (profile.errors.phone.isNotEmpty)
                      ErrorText(text: profile.errors.phone.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Address',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              final profile = state.profileState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'address'),
                    keyboardType: TextInputType.streetAddress,
                    initialValue: user.address,
                    onChanged: (String text) =>
                        profileCubit.addressChange(text),
                  ),
                  if (profile is ProfileStateFormValidate) ...[
                    if (profile.errors.address.isNotEmpty)
                      ErrorText(text: profile.errors.address.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'About me',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              final profile = state.profileState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'about me'),
                    keyboardType: TextInputType.multiline,
                    initialValue: user.aboutMe,
                    onChanged: (String text) =>
                        profileCubit.aboutMeChange(text),
                    maxLines: 4,
                  ),
                  if (profile is ProfileStateFormValidate) ...[
                    if (profile.errors.aboutMe.isNotEmpty)
                      ErrorText(text: profile.errors.aboutMe.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'My Skill',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              final profile = state.profileState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'my skill'),
                    keyboardType: TextInputType.multiline,
                    initialValue: user.mySkill,
                    onChanged: (String text) =>
                        profileCubit.mySkillChange(text),
                    maxLines: 4,
                  ),
                  if (profile is ProfileStateFormValidate) ...[
                    if (profile.errors.mySkill.isNotEmpty)
                      ErrorText(text: profile.errors.mySkill.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Country',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              final profile = state.profileState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Country'),
                    keyboardType: TextInputType.text,
                    initialValue: user.country,
                    onChanged: (String text) =>
                        profileCubit.countryChange(text),
                  ),
                  if (profile is ProfileStateFormValidate) ...[
                    if (profile.errors.country.isNotEmpty)
                      ErrorText(text: profile.errors.country.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Select State',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              final profile = state.profileState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'State'),
                    keyboardType: TextInputType.streetAddress,
                    initialValue: user.state,
                    onChanged: (String text) => profileCubit.stateChange(text),
                  ),
                  if (profile is ProfileStateFormValidate) ...[
                    if (profile.errors.state.isNotEmpty)
                      ErrorText(text: profile.errors.state.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Select City',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              final profile = state.profileState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'City'),
                    keyboardType: TextInputType.streetAddress,
                    initialValue: user.city,
                    onChanged: (String text) {
                      print('city-onchange $text');
                      profileCubit.cityChange(text);
                    },
                  ),
                  if (profile is ProfileStateFormValidate) ...[
                    if (profile.errors.city.isNotEmpty)
                      ErrorText(text: profile.errors.city.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Facebook',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              return TextFormField(
                decoration: const InputDecoration(hintText: 'facebook url'),
                keyboardType: TextInputType.url,
                initialValue: user.facebook,
                onChanged: (String text) => profileCubit.facebookChange(text),
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Linkedin link',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              return TextFormField(
                decoration: const InputDecoration(hintText: 'linkedin url'),
                keyboardType: TextInputType.url,
                initialValue: user.linkedin,
                onChanged: (String text) => profileCubit.linkedinChange(text),
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Twitter link',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              return TextFormField(
                decoration: const InputDecoration(hintText: 'twitter url'),
                keyboardType: TextInputType.url,
                initialValue: user.twitter,
                onChanged: (String text) => profileCubit.twitterChange(text),
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Dribble link',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              return TextFormField(
                decoration: const InputDecoration(hintText: 'dribble url'),
                keyboardType: TextInputType.url,
                initialValue: user.dribbble,
                onChanged: (String text) => profileCubit.dribbbleChange(text),
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Pinterest link',
          bottomSpace: 16.0,
          child: BlocBuilder<ProfileCubit, ProfileStateModel>(
            builder: (context, state) {
              return TextFormField(
                decoration: const InputDecoration(hintText: 'pinterest url'),
                keyboardType: TextInputType.url,
                initialValue: user.pinterest,
                onChanged: (String text) => profileCubit.pinterestChange(text),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    final defaultImage =
        context.read<WebsiteSetupCubit>().setting!.setting!.defaultAvatar;
    return BlocBuilder<ProfileCubit, ProfileStateModel>(
      builder: (context, state) {
        final profile = state.profileState;
        final isThumbImage = state.image.isEmpty;
        final thumbImage = isThumbImage
            ? RemoteUrls.imageUrl(
                user.image.isNotEmpty ? user.image : defaultImage)
            : state.image;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: Utils.vSize(120.0),
                    width: Utils.vSize(120.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFFC2DDFF), width: 4.0),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: Utils.borderRadius(r: 50.0),
                      child: CustomImage(
                        path: thumbImage,
                        isFile: state.image.isNotEmpty,
                        height: Utils.vSize(110.0),
                        width: Utils.hSize(102.0),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 4.0,
                    bottom: 10.0,
                    child: GestureDetector(
                      onTap: () async {
                        final image = await Utils.pickSingleImage();
                        print('captured-image $image');
                        profileCubit.imageChange(image!);
                      },
                      child: CircleAvatar(
                        backgroundColor: primaryColor.withOpacity(0.6),
                        radius: 16.0,
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (profile is ProfileStateFormValidate) ...[
              if (profile.errors.image.isNotEmpty)
                ErrorText(text: profile.errors.image.first),
            ]
          ],
        );
      },
    );
  }
}

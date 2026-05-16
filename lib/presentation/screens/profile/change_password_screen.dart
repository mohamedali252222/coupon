import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubit/change_password/change_password_cubit.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_form.dart';
import '../../widget/custom_text.dart';
import '../../widget/error_text.dart';
import '../../widget/loading_widget.dart';
import '../../widget/primary_button.dart';
import '../authentication/component/custom_authentication_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final passwordCubit = context.read<ChangePasswordCubit>();
    return Scaffold(
      body: CustomAuthenticationWidget(
        height: size.height * 0.35,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Change You Password',
              fontSize: 30.0,
              color: blackColor,
              fontWeight: FontWeight.bold,
            ),
            Utils.verticalSpace(20.0),
            CustomFormWidget(
              label: 'Current Password',
              bottomSpace: 14.0,
              child: BlocBuilder<ChangePasswordCubit, ChangePasswordStateModel>(
                builder: (context, state) {
                  final password = state.passwordChangeState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Current Password',
                          suffixIcon: IconButton(
                            splashRadius: 25.0,
                            onPressed: passwordCubit.showPassword,
                            icon: Icon(
                              state.showCurrentPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: blackColor,
                            ),
                          ),
                        ),
                        initialValue: state.currentPassword,
                        onChanged: (String text) =>
                            passwordCubit.changeCurrentPassword(text),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: state.showCurrentPassword,
                      ),
                      if (password is ChangePasswordFormError) ...[
                        if (password.errors.currentPassword.isNotEmpty)
                          ErrorText(
                              text: password.errors.currentPassword.first),
                      ]
                    ],
                  );
                },
              ),
            ),
            CustomFormWidget(
              label: 'New Password',
              bottomSpace: 14.0,
              child: BlocBuilder<ChangePasswordCubit, ChangePasswordStateModel>(
                builder: (context, state) {
                  final password = state.passwordChangeState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          suffixIcon: IconButton(
                            splashRadius: 25.0,
                            onPressed: passwordCubit.showNewPassword,
                            icon: Icon(
                              state.showNewPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: blackColor,
                            ),
                          ),
                        ),
                        initialValue: passwordCubit.state.newPassword,
                        onChanged: (String text) =>
                            passwordCubit.changeNewPassword(text),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: state.showNewPassword,
                      ),
                      if (state.currentPassword.isNotEmpty)
                        if (password is ChangePasswordFormError) ...[
                          if (password.errors.password.isNotEmpty)
                            ErrorText(text: password.errors.password.first),
                        ]
                    ],
                  );
                },
              ),
            ),
            CustomFormWidget(
              label: 'Confirm Password',
              child: BlocBuilder<ChangePasswordCubit, ChangePasswordStateModel>(
                builder: (context, state) {
                  final password = state.passwordChangeState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(
                            splashRadius: 25.0,
                            onPressed: passwordCubit.showConPassword,
                            icon: Icon(
                              state.showConPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: blackColor,
                            ),
                          ),
                        ),
                        initialValue: state.confirmationPassword,
                        onChanged: (String text) =>
                            passwordCubit.changeConPassword(text),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: state.showConPassword,
                      ),
                      if (state.newPassword.isNotEmpty)
                        if (password is ChangePasswordFormError) ...[
                          if (password.errors.confirmPassword.isNotEmpty)
                            ErrorText(
                                text: password.errors.confirmPassword.first),
                        ]
                    ],
                  );
                },
              ),
            ),
            Utils.verticalSpace(30.0),
            BlocConsumer<ChangePasswordCubit, ChangePasswordStateModel>(
              listener: (context, state) {
                final password = state.passwordChangeState;
                if (password is ChangePasswordStateError) {
                  Utils.errorSnackBar(context, password.message);
                } else if (password is ChangePasswordStateLoaded) {
                  Utils.showSnackBar(context, password.mesage);
                  Navigator.of(context).pop();
                  passwordCubit.clearField();
                }
              },
              builder: (context, state) {
                final password = state.passwordChangeState;
                if (password is ChangePasswordStateLoading) {
                  return const LoadingWidget();
                }
                return PrimaryButton(
                  text: 'Update Password',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    passwordCubit.submitForm();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubit/forgot_password/forgot_password_cubit.dart';
import '../../../logic/cubit/forgot_password/forgot_password_state_model.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_form.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';
import '../../widget/error_text.dart';
import '../../widget/loading_widget.dart';
import '../../widget/primary_button.dart';
import 'component/custom_authentication_widget.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final passwordCubit = context.read<ForgotPasswordCubit>();
    return Scaffold(
      body: CustomAuthenticationWidget(
        height: size.height * 0.5,
        isShowBackButton: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Update Password',
              fontSize: 30.0,
              color: blackColor,
              fontWeight: FontWeight.bold,
            ),
            Utils.verticalSpace(20.0),
            CustomFormWidget(
              label: 'New Password',
              bottomSpace: 14.0,
              child: BlocBuilder<ForgotPasswordCubit, PasswordStateModel>(
                builder: (context, state) {
                  final password = state.passwordState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          suffixIcon: IconButton(
                            splashRadius: 25.0,
                            onPressed: passwordCubit.showPassword,
                            icon: Icon(
                              state.showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: blackColor,
                            ),
                          ),
                        ),
                        initialValue: state.password,
                        onChanged: (String text) =>
                            passwordCubit.changePassword(text),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: state.showPassword,
                      ),
                      if (state.confirmPassword.isNotEmpty ||
                          state.password.isEmpty)
                        if (password is ForgotPasswordFormValidateError) ...[
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
              child: BlocBuilder<ForgotPasswordCubit, PasswordStateModel>(
                builder: (context, state) {
                  final password = state.passwordState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(
                            splashRadius: 25.0,
                            onPressed: passwordCubit.showConfirmPassword,
                            icon: Icon(
                              state.showConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: blackColor,
                            ),
                          ),
                        ),
                        initialValue: state.confirmPassword,
                        onChanged: (String text) =>
                            passwordCubit.changeConfirmPassword(text),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: state.showConfirmPassword,
                      ),
                      if (state.password.isNotEmpty)
                        if (password is ForgotPasswordFormValidateError) ...[
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
            BlocConsumer<ForgotPasswordCubit, PasswordStateModel>(
              listener: (context, state) {
                final password = state.passwordState;
                if (password is ForgotPasswordStateError) {
                  Utils.errorSnackBar(context, password.message);
                } else if (password is PasswordStateUpdated) {
                  Utils.showSnackBar(context, password.message);
                  Navigator.pushNamedAndRemoveUntil(context,
                      RouteNames.authenticationScreen, (route) => false);
                  passwordCubit.clear();
                }
              },
              builder: (context, state) {
                final password = state.passwordState;
                if (password is ForgotPasswordStateLoading) {
                  return const LoadingWidget();
                }
                return PrimaryButton(
                  text: 'Update Password',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    passwordCubit.updatePassword();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _successDialog(BuildContext context) {
    Utils.showCustomDialog(
      context,
      child: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              text: 'Successfully Updated',
              fontSize: 26.0,
              color: blackColor,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            Utils.verticalSpace(5.0),
            const CustomImage(path: KImages.successDialog),
            const CustomText(
              text: 'Thank You',
              fontSize: 30.0,
              color: blackColor,
              fontWeight: FontWeight.bold,
            ),
            Utils.verticalSpace(10.0),
            const CustomText(
              text: 'Your password has been updated',
              fontSize: 18.0,
              color: blackColor,
              fontWeight: FontWeight.w500,
            ),
            Utils.verticalSpace(30.0),
            PrimaryButton(
              text: 'Back to Login',
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.authenticationScreen, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

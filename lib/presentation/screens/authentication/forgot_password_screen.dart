import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubit/forgot_password/forgot_password_cubit.dart';
import '../../../logic/cubit/forgot_password/forgot_password_state_model.dart';
import '../../widget/error_text.dart';
import '../../widget/loading_widget.dart';
import '/presentation/routes/routes_name.dart';
import '/presentation/utils/utils.dart';
import '/presentation/widget/primary_button.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_form.dart';
import '../../widget/custom_text.dart';
import 'component/custom_authentication_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final passwordCubit = context.read<ForgotPasswordCubit>();
    return Scaffold(
      body: CustomAuthenticationWidget(
        height: size.height * 0.65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Forgot Password',
              fontSize: 30.0,
              color: blackColor,
              fontWeight: FontWeight.bold,
            ),
            Utils.verticalSpace(20.0),
            CustomFormWidget(
              label: 'Your email address',
              bottomSpace: 30.0,
              child: BlocBuilder<ForgotPasswordCubit, PasswordStateModel>(
                builder: (context, state) {
                  final password = state.passwordState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'your email address'),
                        keyboardType: TextInputType.emailAddress,
                        initialValue: state.email,
                        onChanged: (String text) =>
                            passwordCubit.changeEmail(text),
                      ),
                      if (password is ForgotPasswordFormValidateError) ...[
                        if (password.errors.email.isNotEmpty)
                          ErrorText(text: password.errors.email.first),
                      ]
                    ],
                  );
                },
              ),
            ),
            BlocConsumer<ForgotPasswordCubit, PasswordStateModel>(
              listener: (context, state) {
                final password = state.passwordState;
                if (password is ForgotPasswordStateError) {
                  Utils.errorSnackBar(context, password.message);
                } else if (password is ForgotPasswordStateLoaded) {
                  Utils.showSnackBar(context, password.message);
                  Navigator.pushNamed(
                      context, RouteNames.verificationCodeScreen,
                      arguments: false);
                }
              },
              builder: (context, state) {
                final password = state.passwordState;
                if (password is ForgotPasswordStateLoading) {
                  return const LoadingWidget();
                }
                return PrimaryButton(
                  text: 'Send Code',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    passwordCubit.forgotPassWord();
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../logic/bloc/login/login_state_model.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/error_text.dart';
import '../../../widget/loading_widget.dart';
import '/presentation/widget/primary_button.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    debugPrint(
        'languageCode-from-login-screen ${loginBloc.state.languageCode}');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomFormWidget(
          label: 'Username or email',
          bottomSpace: 20.0,
          child: BlocBuilder<LoginBloc, LoginStateModel>(
            builder: (context, state) {
              final validate = state.loginState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'username or email',
                    ),
                    initialValue: state.email,
                    onChanged: (String email) =>
                        loginBloc.add(LoginEventUserEmail(email)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (validate is LoginStateFormValidate) ...[
                    if (validate.errors.email.isNotEmpty)
                      ErrorText(text: validate.errors.email.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Password',
          bottomSpace: 14.0,
          child: BlocBuilder<LoginBloc, LoginStateModel>(
            builder: (context, state) {
              final validate = state.loginState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () => loginBloc
                            .add(LoginEventShowPassword(state.showPassword)),
                        icon: Icon(
                            state.showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: blackColor),
                      ),
                    ),
                    initialValue: state.password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: state.showPassword,
                    onChanged: (String password) =>
                        loginBloc.add(LoginEventPassword(password)),
                  ),
                  if (state.email.isNotEmpty)
                    if (validate is LoginStateFormValidate) ...[
                      if (validate.errors.password.isNotEmpty)
                        ErrorText(text: validate.errors.password.first),
                    ]
                ],
              );
            },
          ),
        ),
        _buildRemember(context),
        Utils.verticalSpace(30.0),
        BlocBuilder<LoginBloc, LoginStateModel>(
          builder: (context, state) {
            final loginState = state.loginState;
            if (loginState is LoginStateLoading) {
              return const LoadingWidget();
            }
            return PrimaryButton(
              text: 'Login',
              onPressed: () {
                Utils.closeKeyBoard(context);
                loginBloc.add(const LoginEventSubmit());
                // Navigator.pushNamedAndRemoveUntil(
                //     context, RouteNames.mainScreen, (route) => false);
                // showDialog(
                //     context: context,
                //     barrierDismissible: false,
                //     builder: (context) => const LoginDialog());
              },
            );
          },
        ),
        Utils.verticalSpace(20.0),
        //_guestLogin(context),
      ],
    );
  }

  Widget _guestLogin(BuildContext context) {
    return Column(
      children: [
        const CustomText(
            text: 'OR', fontSize: 18.0, fontWeight: FontWeight.w700),
        Utils.verticalSpace(10.0),
        GestureDetector(
          onTap: () => Navigator.pushNamedAndRemoveUntil(
              context, RouteNames.mainScreen, (route) => false),
          child: const CustomText(
              text: 'Continue as Guest',
              color: greenColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildRemember(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: Utils.only(top: 0.0),
              child: BlocBuilder<LoginBloc, LoginStateModel>(
                builder: (context, state) {
                  return Checkbox(
                    value: state.isRemember,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(Utils.radius(2.4))),
                    activeColor: primaryColor,
                    onChanged: (v) =>
                        loginBloc.add(LoginEventRememberMe(state.isRemember)),
                  );
                },
              ),
            ),
            const CustomText(
              text: 'Remember me',
              color: grayColor,
              fontSize: 14,
              height: 1.6,
            ),
          ],
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, RouteNames.forgotPasswordScreen),
          child: const CustomText(
            text: 'Forgot Password',
            color: redColor,
            height: 1.6,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

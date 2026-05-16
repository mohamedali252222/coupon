import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/bloc/login/login_bloc.dart';
import '../../../../logic/bloc/signup/sign_up_bloc.dart';
import '../../../../logic/bloc/signup/sign_up_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/error_text.dart';
import '../../../widget/loading_widget.dart';
import '../../../widget/primary_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    final signUpBloc = context.read<SignUpBloc>();
    signUpBloc.add(SignUpEventLanguageCode(loginBloc.state.languageCode));
    debugPrint('singup-lang-code ${signUpBloc.state.languageCode}');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomFormWidget(
          label: 'Username',
          bottomSpace: 14.0,
          child: BlocBuilder<SignUpBloc, SignUpStateModel>(
            builder: (context, state) {
              final validate = state.signUpState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'username',
                    ),
                    initialValue: state.name,
                    keyboardType: TextInputType.name,
                    onChanged: (String name) =>
                        signUpBloc.add(SignUpEventName(name)),
                  ),
                  if (validate is SignUpStateFormValidate) ...[
                    if (validate.errors.name.isNotEmpty)
                      ErrorText(text: validate.errors.name.first),
                  ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Email Address',
          bottomSpace: 20.0,
          child: BlocBuilder<SignUpBloc, SignUpStateModel>(
            builder: (context, state) {
              final validate = state.signUpState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'email address',
                    ),
                    initialValue: state.email,
                    onChanged: (String email) =>
                        signUpBloc.add(SignUpEventEmail(email)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (signUpBloc.state.name.isNotEmpty)
                    if (validate is SignUpStateFormValidate) ...[
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
          child: BlocBuilder<SignUpBloc, SignUpStateModel>(
            builder: (context, state) {
              final validate = state.signUpState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () => signUpBloc
                            .add(SignUpEventShowPassword(state.showPassword)),
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
                        signUpBloc.add(SignUpEventPassword(password)),
                  ),
                  if (state.email.isNotEmpty)
                    if (validate is SignUpStateFormValidate) ...[
                      if (validate.errors.password.isNotEmpty)
                        ErrorText(text: validate.errors.password.first),
                    ]
                ],
              );
            },
          ),
        ),
        CustomFormWidget(
          label: 'Confirm Password',
          bottomSpace: 12.0,
          child: BlocBuilder<SignUpBloc, SignUpStateModel>(
            builder: (context, state) {
              final validate = state.signUpState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () => signUpBloc.add(
                            SignUpEventShowConfirmPassword(
                                state.showConfirmPassword)),
                        icon: Icon(
                            state.showConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: blackColor),
                      ),
                    ),
                    initialValue: state.confirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: state.showConfirmPassword,
                    onChanged: (String password) =>
                        signUpBloc.add(SignUpEventPasswordConfirm(password)),
                  ),
                  if (state.confirmPassword.isNotEmpty ||
                      (state.confirmPassword.isEmpty &&
                          !state.confirmPassword.contains(state.password)))
                    if (validate is SignUpStateFormValidate) ...[
                      if (validate.errors.confirmPassword.isNotEmpty)
                        ErrorText(text: validate.errors.confirmPassword.first),
                    ]
                ],
              );
            },
          ),
        ),
        Utils.verticalSpace(20.0),
        BlocBuilder<SignUpBloc, SignUpStateModel>(
          builder: (context, state) {
            final signUpState = state.signUpState;
            if (signUpState is SignUpStateLoading) {
              return const LoadingWidget();
            }
            return PrimaryButton(
              text: 'Sign up',
              onPressed: () {
                Utils.closeKeyBoard(context);
                signUpBloc.add(const SignUpEventSubmit());
              },
            );
          },
        ),
        BlocBuilder<SignUpBloc, SignUpStateModel>(
          builder: (context, state) {
            final errorState = state.signUpState;
            if (errorState is SignUpStateFormValidate) {
              print('error state');
              return Utils.verticalSpace(100.0);
            }
            return Utils.verticalSpace(20.0);
          },
        ),
      ],
    );
  }
}

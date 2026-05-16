import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/bloc/login/login_state_model.dart';
import '../../../logic/bloc/signup/sign_up_bloc.dart';
import '../../../logic/bloc/signup/sign_up_state_model.dart';
import '../../../logic/cubit/forgot_password/forgot_password_cubit.dart';
import '../../../logic/cubit/forgot_password/forgot_password_state_model.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_dialog.dart';
import '../../widget/custom_text.dart';
import '../../widget/primary_button.dart';
import 'component/custom_authentication_widget.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key, required this.isNewUser});

  final bool isNewUser;

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  bool finishTime = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final loginBloc = context.read<LoginBloc>();
    final signUpBloc = context.read<SignUpBloc>();
    final passwordCubit = context.read<ForgotPasswordCubit>();
    debugPrint('signup-email ${signUpBloc.state.email}');
    debugPrint('signup-name ${signUpBloc.state.name}');
    debugPrint('signup-password ${signUpBloc.state.password}');
    debugPrint('signup-confirm_password ${signUpBloc.state.confirmPassword}');
    debugPrint('signup-langCode ${signUpBloc.state.languageCode}');
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<SignUpBloc, SignUpStateModel>(
            listener: (context, state) {
              final signUpState = state.signUpState;
              if (signUpState is SignUpStateLoading ||
                  signUpState is SignUpStateResendCodeLoading) {
                Utils.loadingDialog(context);
              } else {
                if (signUpState is SignUpStateError) {
                  Utils.errorSnackBar(context, signUpState.errorMsg);
                } else if (signUpState
                    is SignUpStateNewUserVerificationLoaded) {
                  loginBloc.add(LoginEventUserEmail(signUpBloc.state.email));
                  loginBloc.add(LoginEventPassword(signUpBloc.state.password));
                  //Utils.showSnackBar(context, signUpState.message);
                  Utils.closeDialog(context);
                  setState(() => finishTime = false);
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => LoginDialog(
                          success: signUpState.message,
                          isNewUser: widget.isNewUser));
                } else if (signUpState is SignUpStateResendCodeLoaded) {
                  Utils.closeDialog(context);
                  Utils.showSnackBar(context, signUpState.message);
                  setState(() => finishTime = true);
                }
              }
            },
          ),
          BlocListener<ForgotPasswordCubit, PasswordStateModel>(
            listener: (context, state) {
              final password = state.passwordState;
              if (password is VerifyingForgotPasswordLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
                if (password is VerifyingForgotPasswordCodeLoaded) {
                  Navigator.pushNamedAndRemoveUntil(context,
                      RouteNames.updatePasswordScreen, (route) => false);
                }
              }
            },
          ),
        ],
        child: CustomAuthenticationWidget(
          height: size.height * 0.65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Verification Code',
                fontSize: 30.0,
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
              Utils.verticalSpace(20.0),
              Pinput(
                length: 6,
                defaultPinTheme: PinTheme(
                  height: Utils.vSize(60.0),
                  width: Utils.hSize(60.0),
                  textStyle: GoogleFonts.rubik(
                    fontSize: 24.0,
                    color: blackColor,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: Utils.borderRadius(r: 6.0),
                  ),
                ),
                onChanged: (String code) {
                  if (widget.isNewUser) {
                    debugPrint('new user change');
                    signUpBloc.add(SignUpEventVerificationCode(code));
                  } else {
                    passwordCubit.changeCode(code);
                    debugPrint('forgot password change');
                  }
                },
                onCompleted: (String code) {
                  if (widget.isNewUser) {
                    debugPrint('new user completed');
                    signUpBloc.add(SignUpEventNewUserSubmit());
                  } else {
                    if (code.isNotEmpty) {
                      passwordCubit.verifyForgotPasswordCode();
                    }
                    debugPrint('forgot password completed');
                  }
                },
              ),
              Utils.verticalSpace(20.0),
              widget.isNewUser ? _countDownTime() : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _countDownTime() {
    final signUpBloc = context.read<SignUpBloc>();
    if (finishTime) {
      return Align(
        alignment: Alignment.center,
        child: TimerCountdown(
          format: CountDownTimerFormat.secondsOnly,
          enableDescriptions: false,
          spacerWidth: 6.0,
          timeTextStyle: GoogleFonts.poppins(
            fontSize: 30.0,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
          colonsTextStyle: GoogleFonts.poppins(
            fontSize: 30.0,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
          endTime: DateTime.now().add(
            const Duration(minutes: 1),
          ),
          onEnd: () {
            print('finish');
            setState(() => finishTime = false);
          },
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomText(
              text: 'Don\'t get verification code', fontSize: 14.0),
          GestureDetector(
            onTap: () =>
                signUpBloc.add(const SignUpEventResendVerificationSubmit()),
            child: const CustomText(
              text: 'Resend Code',
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: greenColor,
            ),
          ),
        ],
      );
    }
  }
}

class LoginDialog extends StatelessWidget {
  const LoginDialog(
      {super.key, required this.success, required this.isNewUser});

  final String success;
  final bool isNewUser;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    final signUpBloc = context.read<SignUpBloc>();
    final size = MediaQuery.sizeOf(context);
    return BlocListener<LoginBloc, LoginStateModel>(
      listener: (context, state) {
        final login = state.loginState;
        if (login is LoginStateLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (login is LoginStateError) {
            Utils.errorSnackBar(context, login.message);
          } else if (login is LoginStateLoaded) {
            Navigator.pop(context);
            //Utils.closeDialog(context);
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.mainScreen, (route) => false);
            // if (isNewUser) {
            //   debugPrint('new user registration');
            //   signUpBloc.add(const SignUpEventFormDataClear());
            // } else {
            //   debugPrint('not new user');
            // }
          }
        }
      },
      child: CustomDialog(
        icon: KImages.done,
        height: size.height * 0.3,
        child: Column(
          children: [
            CustomText(
              text: success,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: blackColor,
              textAlign: TextAlign.center,
            ),
            Utils.verticalSpace(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PrimaryButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.of(context).pop();
                    //registerBloc.add(RegisterEventClear());
                    Navigator.pushNamedAndRemoveUntil(context,
                        RouteNames.authenticationScreen, (route) => false);
                  },
                  borderRadiusSize: 6.0,
                  bgColor: blackColor,
                  fontSize: 16.0,
                  minimumSize: Size(Utils.hSize(125.0), Utils.vSize(52.0)),
                ),
                PrimaryButton(
                  text: 'Login',
                  onPressed: () => loginBloc.add(const LoginEventSubmit()),
                  bgColor: greenColor,
                  borderRadiusSize: 6.0,
                  fontSize: 16.0,
                  minimumSize: Size(Utils.hSize(125.0), Utils.vSize(52.0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

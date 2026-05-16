import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../logic/bloc/login/login_state_model.dart';
import '../../../logic/bloc/signup/sign_up_state_model.dart';
import '../../../state_packages_name.dart';
import '../../routes/routes_name.dart';
import '../../widget/custom_text.dart';
import '../../widget/exit_from_app.dart';
import '/presentation/utils/constraints.dart';
import '/presentation/utils/utils.dart';
import 'component/custom_authentication_widget.dart';
import 'component/sign_in_form.dart';
import 'component/sign_up_form.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  int _index = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const ExitFromApp(),
        );
        return true;
      },
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<LoginBloc, LoginStateModel>(
              listener: (context, state) {
                final loginState = state.loginState;
                if (loginState is LoginStateError) {
                  Utils.errorSnackBar(context, loginState.message);
                } else if (loginState is LoginStateLoaded) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.mainScreen, (route) => false);
                }
              },
            ),
            BlocListener<SignUpBloc, SignUpStateModel>(
              listener: (context, state) {
                final signUpState = state.signUpState;
                if (signUpState is SignUpStateError) {
                  Utils.errorSnackBar(context, signUpState.errorMsg);
                } else if (signUpState is SignUpStateLoaded) {
                  Utils.showSnackBar(context, signUpState.msg);
                  Navigator.pushNamedAndRemoveUntil(context,
                      RouteNames.verificationCodeScreen, (route) => false,
                      arguments: true);
                }
              },
            ),
          ],
          child: CustomAuthenticationWidget(
            height: size.height * 0.2,
            isShowBackButton: false,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeText(),
                  Utils.verticalSpace(12.0),
                  _buildSelectedTab(),
                  Utils.verticalSpace(12.0),
                  ExpandablePageView(
                    onPageChanged: (int page) => setState(() => _index = page),
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    children: forms,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return AnimatedContainer(
      duration: kDuration,
      child: CustomText(
        text: _index == 0 ? 'Welcome Back!' : 'Create Account',
        fontSize: 30.0,
        color: blackColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSelectedTab() {
    return Row(
      children: [
        InkWell(
          onTap: () => controller.animateToPage(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceInOut),
          child: CustomText(
            text: tabText[0],
            fontSize: 18.0,
            color: _index == 0 ? blackColor : grayColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          color: const Color(0xFF9D9D9D),
          width: 2,
          height: 18,
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
        InkWell(
          onTap: () => controller.animateToPage(1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceInOut),
          child: CustomText(
            text: tabText[1],
            fontSize: 18.0,
            color: _index == 1 ? blackColor : grayColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

List<String> tabText = const ['Login', 'Sign Up'];
List<Widget> forms = const [SignInForm(), SignUpForm()];

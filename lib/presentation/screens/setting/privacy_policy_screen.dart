import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../logic/cubit/language_code_state.dart';
import '../../../logic/cubit/privacy_policy/privacy_policy_cubit.dart';
import '../../../state_packages_name.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final privacyCubit = context.read<PrivacyPolicyCubit>();
    privacyCubit.getPrivacyPolicy();
    if (privacyCubit.privacyText == null) {
      privacyCubit.getPrivacyPolicy();
    }
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocBuilder<PrivacyPolicyCubit, LanguageCodeState>(
        builder: (context, state) {
          final policy = state.privacyPolicyState;
          if (policy is PrivacyPolicyLoading) {
            return const Center(child: LoaderCircle());
          } else if (policy is PrivacyPolicyError) {
            if (policy.statusCode == 503) {
              if (privacyCubit.privacyText!.isNotEmpty ||
                  privacyCubit.privacyText != null) {
                return LoadedPrivacyPolicyText(
                    privacyText: privacyCubit.privacyText!);
              } else {
                return const FetchErrorText(text: 'Network problem');
              }
            }
            return const FetchErrorText(text: 'Something goes wrong!');
          } else if (policy is PrivacyPolicyLoaded) {
            return LoadedPrivacyPolicyText(privacyText: policy.privacyPolicy);
          }
          if (privacyCubit.privacyText!.isNotEmpty ||
              privacyCubit.privacyText != null) {
            return LoadedPrivacyPolicyText(
                privacyText: privacyCubit.privacyText!);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

class LoadedPrivacyPolicyText extends StatelessWidget {
  const LoadedPrivacyPolicyText({super.key, required this.privacyText});

  final String privacyText;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'Privacy Policy',
          isGradientBg: true,
          iconColor: whiteColor,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: Utils.symmetric(),
            child: Html(data: privacyText), // ✅ Correctly put Html widget here
          ),
        )
      ],
    );
  }
}

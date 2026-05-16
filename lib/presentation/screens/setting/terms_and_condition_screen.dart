import 'package:alas_mart/presentation/widget/loader_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../logic/cubit/language_code_state.dart';
import '../../../logic/cubit/privacy_policy/privacy_policy_cubit.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loading_widget.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final privacyCubit = context.read<PrivacyPolicyCubit>();
    privacyCubit.getTermsAndCondition();
    if (privacyCubit.termsConditionText == null) {
      privacyCubit.getTermsAndCondition();
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
              if (privacyCubit.termsConditionText!.isNotEmpty ||
                  privacyCubit.termsConditionText != null) {
                return LoadedPrivacyPolicyText(
                    termsConditionText: privacyCubit.termsConditionText!);
              } else {
                return const FetchErrorText(text: 'Network problem');
              }
            }
            return const FetchErrorText(text: 'Something goes wrong!');
          } else if (policy is TermsAndConditionLoaded) {
            return LoadedPrivacyPolicyText(
                termsConditionText: policy.termsConditions);
          }
          if (privacyCubit.termsConditionText!.isNotEmpty ||
              privacyCubit.termsConditionText != null) {
            return LoadedPrivacyPolicyText(
                termsConditionText: privacyCubit.termsConditionText!);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

class LoadedPrivacyPolicyText extends StatelessWidget {
  const LoadedPrivacyPolicyText({super.key, required this.termsConditionText});

  final String termsConditionText;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'Terms and Condition',
          isGradientBg: true,
          iconColor: whiteColor,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: Utils.symmetric(),
            child: Html(data: termsConditionText), // ✅ Correctly put Html widget here
          ),
        )
      ],
    );
  }
}

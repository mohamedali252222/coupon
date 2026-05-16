import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/faq/faq_model.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../logic/cubit/privacy_policy/privacy_policy_cubit.dart';
import '../../utils/constraints.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';
import 'component/single_expansion_tile.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final privacyCubit = context.read<PrivacyPolicyCubit>();
    privacyCubit.getFaqContent();
    // if (privacyCubit.privacyText == null) {
    //   privacyCubit.getFaqContent();
    // }
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocBuilder<PrivacyPolicyCubit, LanguageCodeState>(
        builder: (context, state) {
          final policy = state.privacyPolicyState;
          if (policy is PrivacyPolicyLoading) {
            return const Center(child: LoaderCircle());
          } else if (policy is PrivacyPolicyError) {
            if (policy.statusCode == 503) {
              return LoadedFaqContent(faqContent: privacyCubit.faqContent);
            }
            return const FetchErrorText(text: 'Something goes wrong!');
          } else if (policy is FaqContentLoaded) {
            return LoadedFaqContent(faqContent: policy.faqContent);
          }
          if (privacyCubit.faqContent.isNotEmpty) {
            return LoadedFaqContent(faqContent: privacyCubit.faqContent);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

class LoadedFaqContent extends StatelessWidget {
  const LoadedFaqContent({super.key, required this.faqContent});

  final List<FaqContent> faqContent;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'F A Q',
          isGradientBg: true,
          iconColor: whiteColor,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final faq = faqContent[index];
              return SingleExpansionTile(
                isExpand: index == 0,
                question: faq.faqContent!.question,
                answer: faq.faqContent!.answer,
              );
            },
            childCount: faqContent.length,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/models/contact_us/contact_us_model.dart';
import '../../../logic/cubit/contact_us/contact_us_cubit.dart';
import '../../../logic/cubit/contact_us/contact_us_state_model.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/custom_text.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';
import 'component/contact_us_form.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final privacyCubit = context.read<ContactUsCubit>();
    privacyCubit.getContactUs();
    if (privacyCubit.contactUs == null) {
      //privacyCubit.getContactUs();
    }
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocBuilder<ContactUsCubit, ContactUsStateModel>(
        builder: (context, state) {
          final policy = state.contactUsState;
          if (policy is ContactUsLoading) {
            return const Center(child: LoaderCircle());
          } else if (policy is ContactUsError) {
            if (policy.statusCode == 503) {
              if (privacyCubit.contactUs != null) {
                return ContactUsLoadedWidget(contact: privacyCubit.contactUs!);
              } else {
                return const FetchErrorText(text: 'Network problem');
              }
            }
            return const FetchErrorText(text: 'Something goes wrong!');
          } else if (policy is ContactUsLoaded) {
            return ContactUsLoadedWidget(contact: policy.contactUs);
          }
          if (privacyCubit.contactUs != null) {
            return ContactUsLoadedWidget(contact: privacyCubit.contactUs!);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

class ContactUsLoadedWidget extends StatefulWidget {
  const ContactUsLoadedWidget({super.key, required this.contact});

  final ContactComponent contact;

  @override
  State<ContactUsLoadedWidget> createState() => _ContactUsLoadedWidgetState();
}

class _ContactUsLoadedWidgetState extends State<ContactUsLoadedWidget> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    initController();
  }

  initController() {
    controller = WebViewController();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'Contact us',
          iconColor: whiteColor,
          isGradientBg: true,
        ),
        SliverPadding(
          padding: Utils.symmetric(v: 20.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const ContactUsForm(),
              Utils.verticalSpace(30.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ContactInfo(
                    icon: Icons.email_outlined,
                    title: 'Mail Address',
                    subTitle: widget.contact.email,
                  ),
                  ContactInfo(
                    icon: Icons.phone,
                    title: 'Phone Number',
                    subTitle: widget.contact.phone,
                  ),
                ],
              ),
              Padding(
                padding: Utils.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ContactInfo2(
                      icon: Icons.location_on,
                      title: 'Contact Address',
                      subTitle: widget.contact.address,
                    ),


                  ],
                ),
              ),
              Container(
                height: 200.0,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                alignment: Alignment.center,
                child: WebViewWidget(
                  controller: controller
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..enableZoom(true)
                  //..setBackgroundColor(whiteColor)
                    ..loadHtmlString(widget.contact.map),
                ),
              ),
            ]),
          ),
        )
      ],
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.fontSize = 12.0,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String subTitle;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: Utils.all(value: 6.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFFF9B546),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: whiteColor),
        ),
        Utils.verticalSpace(8.0),
        CustomText(text: title),
        Utils.verticalSpace(8.0),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Flexible(
            child: CustomText(
                text: subTitle,
                fontWeight: FontWeight.w500,
                maxLine: 2,
                fontSize: fontSize),
          ),
        ),
      ],
    );
  }
}

class ContactInfo2 extends StatelessWidget {
  const ContactInfo2({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.fontSize = 12.0,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String subTitle;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: Utils.all(value: 6.0),
            decoration: const BoxDecoration(
              color: Color(0xFFF9B546),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: whiteColor),
          ),
          Utils.verticalSpace(8.0),
          CustomText(text: title),
          Utils.verticalSpace(8.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Expanded(
              child: CustomText(
                  text: subTitle,
                  fontWeight: FontWeight.w500,
                  maxLine: 2,
                  fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }
}

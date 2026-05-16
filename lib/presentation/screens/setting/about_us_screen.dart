import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/dummy_data/dummy_data.dart';
import '../../../data/models/about_us/about_us_model.dart';
import '../../../data/models/about_us/team_section.dart';
import '../../../data/models/about_us/testimonial.dart';
import '../../../logic/cubit/about_us/about_us_cubit.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/custom_text.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final privacyCubit = context.read<AboutUsCubit>();
    privacyCubit.getAboutUs();
    if (privacyCubit.aboutUs == null) {
      debugPrint('about-us got NUll');
      // privacyCubit.getAboutUs();
    }
    return Scaffold(
      //  backgroundColor: whiteColor,
      body: BlocBuilder<AboutUsCubit, LanguageCodeState>(
        builder: (context, state) {
          final policy = state.aboutUsState;
          if (policy is AboutUsLoading) {
            return const Center(child: LoaderCircle());
          } else if (policy is AboutUsError) {
            if (policy.statusCode == 503) {
              if (privacyCubit.aboutUs != null) {
                return LoadedAboutUsWidget(aboutUs: privacyCubit.aboutUs!);
              } else {
                return const FetchErrorText(text: 'Network problem');
              }
            }
            return const FetchErrorText(text: 'Something goes wrong!');
          } else if (policy is AboutUsLoaded) {
            return LoadedAboutUsWidget(aboutUs: policy.aboutUs);
          }
          if (privacyCubit.aboutUs != null) {
            return LoadedAboutUsWidget(aboutUs: privacyCubit.aboutUs!);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

class LoadedAboutUsWidget extends StatefulWidget {
  const LoadedAboutUsWidget({super.key, required this.aboutUs});

  final AboutUsModel aboutUs;

  @override
  State<LoadedAboutUsWidget> createState() => _LoadedAboutUsWidgetState();
}

class _LoadedAboutUsWidgetState extends State<LoadedAboutUsWidget> {
  late int totalClient;
  late PageController clientSliderController;
  late PageController clientFeedbackController;
  int clientSliderCurrentIndex = 0;
  int clientFeedbackCurrentIndex = 0;

  List<String> firstName = [];

  @override
  void initState() {
    totalClient = expertise.length;
    clientSliderController = PageController(
        viewportFraction: 0.6, initialPage: totalClient > 1 ? 1 : 0);
    clientFeedbackController = PageController(viewportFraction: 0.9);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final aboutUs = widget.aboutUs;
    final header = aboutUs.aboutUs!.aboutlangfrontend!;
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'About us',
          iconColor: whiteColor,
          isGradientBg: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: Utils.symmetric(v: 20.0).copyWith(bottom: 30.0),
                child: Column(
                  children: [
                    CustomText(
                      text:
                          '${header.header1} ${header.header2} ${header.header3}',
                      color: blackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      textAlign: TextAlign.left,
                    ),
                    // ReadMoreText(
                    //   'widget.aboutUs',
                    //   style: GoogleFonts.rubik(
                    //       fontSize: 16.0, color: blackColor.withOpacity(0.7)),
                    // ),
                    Html(data: header.aboutUs),
                    Utils.verticalSpace(15.0),
                    CustomImage(
                      path: RemoteUrls.imageUrl(aboutUs.aboutUs!.bannerImage),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              _buildClientSlider(size, aboutUs.ourTeemSection!),
              Container(
                height: Utils.vSize(200.0),
                width: size.width,
                margin: Utils.symmetric(h: 0.0, v: 40.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImage(
                      //path: RemoteUrls.imageUrl(aboutUs.aboutUs!.bannerImage),
                      path: KImages.chooseBg,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 20.0,
                      left: 0.0,
                      right: 0.0,
                      child: CustomText(
                        text: aboutUs.whyChooseUs!.title2,
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned.fill(
                      top: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildChooseItem(aboutUs.whyChooseUs!.itemIcon1,
                              aboutUs.whyChooseUs!.itemTitle1),
                          _buildChooseItem(aboutUs.whyChooseUs!.itemIcon2,
                              aboutUs.whyChooseUs!.itemTitle2),
                          _buildChooseItem(aboutUs.whyChooseUs!.itemIcon3,
                              aboutUs.whyChooseUs!.itemTitle3),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              _buildClientFeedback(size, aboutUs.testimonialSection!),
              Utils.verticalSpace(size.height * 0.05)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChooseItem(String icon, String text) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Utils.vSize(70.0),
            width: Utils.vSize(70.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
            ),
            child: CustomImage(
              path: RemoteUrls.imageUrl(icon),
            ),
          ),
          Utils.verticalSpace(6.0),
          CustomText(
            text: text,
            color: whiteColor,
            fontSize: 12.0,
            maxLine: 2,
            softWrap: true,
            height: 1.6,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildClientSlider(Size size, OurTeemSection team) {
    return SizedBox(
      width: double.infinity,
      //color: const Color(0xFFEFEFEF).withOpacity(0.6),
      child: Column(
        children: [
          CustomText(
            text: team.title,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
            textAlign: TextAlign.center,
          ),
          Utils.verticalSpace(14.0),
          SizedBox(
            height: Utils.vSize(size.height * 0.3),
            //width: Utils.hSize(size.width),
            child: PageView(
              controller: clientSliderController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (int position) =>
                  setState(() => clientSliderCurrentIndex = position),
              children: List.generate(team.ourTeems!.length, (index) {
                final item = team.ourTeems![index];

                return Container(
                  padding: Utils.symmetric(v: 0.0, h: 0.0),
                  margin: Utils.only(right: 16.0),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: Utils.borderRadius(r: 6.0),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Color(0x33000000),
                    //     blurRadius: 10,
                    //     offset: Offset(0, 10),
                    //     spreadRadius: 0,
                    //   ),
                    // ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: Utils.vSize(100.0),
                        width: Utils.vSize(100.0),
                        margin: Utils.only(bottom: 14.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: whiteColor, width: 1.5),
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: Utils.borderRadius(r: 45.0),
                          child: CustomImage(
                            path: RemoteUrls.imageUrl(item.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      CustomText(
                        text: item.teamlangfrontend!.name,
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                        textAlign: TextAlign.center,
                      ),
                      Utils.verticalSpace(2.0),
                      CustomText(
                        text: item.teamlangfrontend!.designation,
                        color: grayColor,
                        fontSize: 14.0,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          Utils.verticalSpace(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              team.ourTeems!.length,
              (index) => AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: Utils.vSize(8.0),
                width: Utils.hSize(
                    clientSliderCurrentIndex == index ? 20.0 : 30.0),
                margin: Utils.only(right: 6.0),
                decoration: BoxDecoration(
                  color: clientSliderCurrentIndex == index
                      ? primaryColor
                      : primaryColor.withOpacity(0.2),
                  borderRadius: Utils.borderRadius(r: 6.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientFeedback(Size size, TestimonialSection testimonial) {
    return SizedBox(
      width: double.infinity,
      //color: const Color(0xFFEFEFEF).withOpacity(0.6),
      child: Column(
        children: [
          CustomText(
            text: testimonial.description,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
            textAlign: TextAlign.center,
          ),
          Utils.verticalSpace(14.0),
          SizedBox(
            height: Utils.vSize(size.height * 0.3),
            //width: Utils.hSize(size.width),
            child: PageView(
              controller: clientFeedbackController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (int position) =>
                  setState(() => clientFeedbackCurrentIndex = position),
              children:
                  List.generate(testimonial.testimonials!.length, (index) {
                final item = testimonial.testimonials![index];

                return Container(
                  padding: Utils.symmetric(),
                  margin: Utils.only(right: 16.0),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: Utils.borderRadius(r: 6.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: List.generate(
                          item.rating.toInt(),
                          (index) => const Icon(
                            Icons.star,
                            size: 18.0,
                            color: secondaryColor,
                          ),
                        ),
                      ),
                      Utils.verticalSpace(10.0),
                      CustomText(
                        text: item.testimoniallangfrontend!.comment,
                        color: grayColor,
                        fontSize: 16.0,
                        maxLine: 3,
                      ),
                      Utils.verticalSpace(10.0),
                      Row(
                        children: [
                          Container(
                            height: Utils.vSize(80.0),
                            width: Utils.vSize(80.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: whiteColor, width: 1.5),
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: Utils.borderRadius(r: 45.0),
                              child: CustomImage(
                                path: RemoteUrls.imageUrl(item.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Utils.horizontalSpace(10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: splitFirstName(
                                    item.testimoniallangfrontend!.name),
                                color: blackColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                              Utils.verticalSpace(4.0),
                              CustomText(
                                text: item.testimoniallangfrontend!.designation,
                                color: grayColor,
                                fontSize: 14.0,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          Utils.verticalSpace(14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              testimonial.testimonials!.length,
              (index) => AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: Utils.vSize(8.0),
                width: Utils.hSize(
                    clientFeedbackCurrentIndex == index ? 20.0 : 30.0),
                margin: Utils.only(right: 6.0),
                decoration: BoxDecoration(
                  color: clientFeedbackCurrentIndex == index
                      ? primaryColor
                      : primaryColor.withOpacity(0.2),
                  borderRadius: Utils.borderRadius(r: 6.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String splitFirstName(String text) {
    firstName = text.split(' ');
    return firstName.isNotEmpty ? firstName[0] : '';
  }
}

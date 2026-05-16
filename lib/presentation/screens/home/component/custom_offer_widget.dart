import 'package:alas_mart/data/data_provider/remote_url.dart';
import 'package:alas_mart/presentation/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../logic/cubit/home/home_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';

class CustomOfferWidget extends StatelessWidget {
  const CustomOfferWidget(
      {super.key,
      required this.children,
      this.height = 226.0,
      this.bgImage = KImages.offerBg});

  final List<Widget> children;
  final double height;
  final String bgImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Utils.vSize(height),
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomImage(
            path: bgImage,
            fit: BoxFit.cover,
          ),
          ...children,
        ],
      ),
    );
  }
}

class OfferWidget extends StatelessWidget {
  const OfferWidget(
      {super.key, required this.headingText, required this.buttonText});

  final String buttonText;
  final String headingText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final homeCubit = context.read<HomeCubit>();
    final offer = homeCubit.homeModel!.specialOffer;
    // debugPrint('offer-bg ${offer!.home2Background.runtimeType}');
    return CustomOfferWidget(
      height: 160.0,
      bgImage: RemoteUrls.imageUrl(offer!.home3Background),
      children: [
        Positioned(
            top: Utils.vSize(16.0),
            left: 0.0,
            right: 0.0,
            child: Padding(
              padding: Utils.symmetric(),
              // child: CustomText(
              //   text: offer!.title1,
              //   fontSize: 18.0,
              //   maxLine: 3,
              //   height: 1.6,
              //   color: whiteColor,
              //   textAlign: TextAlign.center,
              // ),
              child: _offerWidget(offer.title1),
            )),
        Positioned(
          bottom: Utils.vSize(20.0),
          left: 0.0,
          right: 0.0,
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              RouteNames.specialOfferScreen,
              arguments: offer.link,
            ),
            child: Container(
              alignment: Alignment.center,
              padding: Utils.symmetric(h: 0.0, v: 12.0),
              margin: Utils.symmetric(h: size.width / 4.0),
              decoration: ShapeDecoration(
                gradient: linearGradient2,
                shape: RoundedRectangleBorder(
                    borderRadius: Utils.borderRadius(r: 6.0)),
              ),
              child: CustomText(
                text: buttonText,
                color: blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _offerWidget(String text) {
    return Html(
      data: text,
      style: {
        '*': Style(
          fontSize: FontSize.medium,
          color: whiteColor,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        ),
        'span': Style(
          fontSize: FontSize.large,
          color: whiteColor,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
        ),
      },
    );
  }
}

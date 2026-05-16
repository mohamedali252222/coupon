import 'package:flutter/material.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/home/introduction/introduction_model.dart';
import '../../../routes/routes_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';
import 'custom_offer_widget.dart';

class TopOfferSection extends StatelessWidget {
  const TopOfferSection({super.key, required this.introduction});

  final IntroductionModel introduction;

  @override
  Widget build(BuildContext context) {
    final content = introduction.content!;
    return CustomOfferWidget(
        bgImage: RemoteUrls.imageUrl(content.home2Bg),
        children: [
          Positioned(
              top: Utils.vSize(20.0),
              left: 0.0,
              right: 0.0,
              child: CustomText(
                text: content.sliderLangFontEnd!.home1Title,
                fontSize: 20.0,
                maxLine: 3,
                fontWeight: FontWeight.w700,
                color: whiteColor,
                height: 1.4,
                textAlign: TextAlign.center,
              )),
          Positioned(
            top: Utils.vSize(100.0),
            left: 0.0,
            right: 0.0,
            child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.searchScreen),
              child: Container(
                height: Utils.vSize(55.0),
                margin: Utils.symmetric(),
                padding: Utils.symmetric(),
                width: double.infinity,
                decoration: ShapeDecoration(
                    color: whiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: Utils.borderRadius())),
                child: Row(
                  children: [
                    Padding(
                        padding: Utils.only(top: 4.0),
                        child: const Icon(Icons.search,
                            color: blueGrayColor, size: 24.0)),
                    Utils.horizontalSpace(10.0),
                    const CustomText(text: 'search your product..',fontSize: 12,),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Utils.vSize(30.0),
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _serviceCount('${content.totalProduct}+ Products'),
                _serviceCount('${content.totalUser}+ User'),
                _serviceCount('${content.totalSold}+ Sell', false),
              ],
            ),
          ),
        ]);
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
      enabled: false,
      onTap: () => Navigator.pushNamed(context, RouteNames.searchScreen),
      decoration: InputDecoration(
        hintText: 'search your product..',
        prefixIcon: const Icon(Icons.search, color: blueGrayColor, size: 28.0),
        suffixIcon: GestureDetector(
          onTap: () {
            print('clieckk');
            Navigator.pushNamed(context, RouteNames.searchScreen);
          },
          child: Container(
            width: Utils.hSize(90.0),
            alignment: Alignment.center,
            margin: Utils.all(value: 4.0),
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.80, -0.60),
                end: Alignment(-0.8, 0.6),
                colors: [Color(0xFF8D49FE), Color(0xFF013CB0)],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: Utils.borderRadius(r: 6.0)),
            ),
            child: const CustomText(
              text: 'Search',
              color: whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),
        filled: false,
        enabled: true,
      ),
    );
  }

  Widget _serviceCount(String text, [bool isShowLine = true]) {
    return Row(
      children: [
        CustomText(
          text: text,
          color: whiteColor,
          fontSize: 14,
        ),
        isShowLine
            ? Container(
                height: 14.0,
                width: 1.0,
                margin: Utils.symmetric(h: 12.0),
                color: whiteColor,
              )
            : const SizedBox(),
      ],
    );
  }
}

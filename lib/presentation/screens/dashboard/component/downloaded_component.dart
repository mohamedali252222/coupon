import 'package:alas_mart/presentation/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/download/download_model.dart';
import '../../../../logic/cubit/download/download_cubit.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';

class DownloadedComponent extends StatelessWidget {
  const DownloadedComponent({super.key, required this.theme});

  final DownloadItem theme;

  @override
  Widget build(BuildContext context) {
    final downloadCubit = context.read<DownloadCubit>();
    return Container(
      padding: Utils.symmetric(v: 12.0),
      margin: Utils.symmetric(v: 16.0, h: 12.0).copyWith(top: 0.0),
      //height: Utils.vSize(140.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: Utils.borderRadius(),
        boxShadow: const [
          BoxShadow(
            color: Color(0x23000000),
            blurRadius: 84,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              children: [
                SizedBox(
                  height: 100.0,
                  width: 160.0,
                  child: ClipRRect(
                      borderRadius: Utils.borderRadius(r: 6.0),
                      child: CustomImage(
                        path:
                            RemoteUrls.imageUrl(theme.product!.thumbnailImage),
                        fit: BoxFit.cover,
                      )),
                ),
                Flexible(
                  child: Padding(
                    padding: Utils.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                            text: theme.productType,
                            fontSize: 16.0,
                            color: primaryColor),
                        Utils.verticalSpace(8.0),
                        Flexible(
                          fit: FlexFit.loose,
                          child: CustomText(
                            text: theme.product!.productLangFrontEnd!.name,
                            color: blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            maxLine: 2,
                            height: 1.6,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Utils.verticalSpace(4.0),
                        CustomText(
                          text: Utils.formatPrice(context, theme.price),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Utils.verticalSpace(6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Row(
              //   children: List.generate(
              //     theme.product!.totalRating,
              //     (index) => const Icon(
              //       Icons.star,
              //       size: 18.0,
              //       color: secondaryColor,
              //     ),
              //   ),
              // ),
              // ProductRating(rating: theme.product!.totalRating),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, RouteNames.reviewScreen,
                    arguments: theme),
                child: Container(
                  padding: Utils.symmetric(h: 10.0, v: 6.0),
                  decoration: BoxDecoration(
                    borderRadius: Utils.borderRadius(r: 6.0),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: Utils.only(top: 0.0),
                        child: const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 22.0,
                        ),
                      ),
                      const CustomText(
                        text: 'Review Us',
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {

                  if (theme.productType == 'script') {
                    bool permissionGranted =
                        await Utils.getStoragePermissions();
                    if (permissionGranted) {
                      final r = await downloadCubit
                          .downloadFile(theme.productId.toString());
                      r.fold(
                        (failure) {
                          Utils.errorSnackBar(context, "Something went wrong!");
                        },
                        (success) {
                          if (success) {
                            Utils.showSnackBar(context, "Downloaded");
                          } else {
                            Utils.errorSnackBar(context, "Download Failed");
                          }
                        },
                      );
                    }
                  } else {
                    if (theme.variant != null) {
                      bool permissionGranted =
                          await Utils.getStoragePermissions();
                      if (permissionGranted) {
                        final r = await downloadCubit
                            .downloadVariantFile(theme.variantId.toString());
                        r.fold(
                          (failure) {
                            Utils.errorSnackBar(
                                context, "Something went wrong!");
                          },
                          (success) {
                            if (success) {
                              Utils.showSnackBar(context, "Downloaded");
                            } else {
                              Utils.errorSnackBar(context, "Download Failed");
                            }
                          },
                        );
                      }
                    }
                  }
                },
                child: Container(
                  padding: Utils.symmetric(h: 10.0, v: 6.0),
                  decoration: BoxDecoration(
                    borderRadius: Utils.borderRadius(r: 6.0),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: Utils.only(top: 0.0),
                        child: const Icon(
                          Icons.download_outlined,
                          color: whiteColor,
                          size: 22.0,
                        ),
                      ),
                      const CustomText(
                        text: 'Download',
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

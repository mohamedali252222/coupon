import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../logic/bloc/upload_product/upload_product_bloc.dart';
import '../../../../logic/bloc/upload_product/upload_product_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/error_text.dart';

class ImageIconWidget extends StatelessWidget {
  const ImageIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final uploadBloc = context.read<UploadProductBloc>();
    return BlocBuilder<UploadProductBloc, UploadProductStateModel>(
      builder: (context, state) {
        final validate = state.uploadProductState;
        final thumbImage = state.thumbImage.isNotEmpty;
        final productIcon = state.productIcon.isNotEmpty;
        return Padding(
          padding: Utils.symmetric(h: 0.0, v: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Utils.vSize(120.0),
                    width: Utils.hSize(size.width * 0.4),
                    decoration: BoxDecoration(
                      color: borderColor2,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final thumbnail = await Utils.pickSingleImage();
                        uploadBloc
                            .add(UploadProductThumbImageEvent(thumbnail ?? ''));
                      },
                      child: thumbImage
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CustomImage(
                                      fit: BoxFit.cover,
                                      path: state.thumbImage,
                                      isFile: thumbImage),
                                  Positioned(
                                    right: Utils.hSize(0.0),
                                    top: Utils.vSize(5.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final thumbnail =
                                            await Utils.pickSingleImage();
                                        uploadBloc.add(
                                            UploadProductThumbImageEvent(
                                                thumbnail ?? ''));
                                      },
                                      child: _circleAvatar(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  const CustomImage(path: KImages.galleryIcon2),
                                  Utils.verticalSpace(10.0),
                                  const CustomText(
                                    text: 'Choose Thumbnail',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF0049FF),
                                  )
                                ]),
                    ),
                  ),
                  if (validate is UploadProductFormError) ...[
                    if (validate.errors.thumbImage.isNotEmpty)
                      ErrorText(text: validate.errors.thumbImage.first),
                  ]
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Utils.vSize(120.0),
                    width: Utils.hSize(size.width * 0.4),
                    decoration: BoxDecoration(
                      color: borderColor2,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        final icon = await Utils.pickSingleImage();
                        if (icon!.isNotEmpty) {
                          uploadBloc.add(UploadProductIconEvent(icon));
                        }
                      },
                      child: productIcon
                          ? Padding(
                              padding:
                                  EdgeInsets.all(Utils.vPadding(size: 6.0)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CustomImage(
                                      path: state.productIcon,
                                      isFile: productIcon),
                                  Positioned(
                                    right: Utils.hSize(0.0),
                                    top: Utils.vSize(5.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final icon =
                                            await Utils.pickSingleImage();
                                        uploadBloc.add(
                                            UploadProductIconEvent(icon ?? ''));
                                      },
                                      child: _circleAvatar(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomImage(path: KImages.galleryIcon2),
                                Utils.verticalSpace(10.0),
                                const CustomText(
                                  text: 'Choose Icon',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0049FF),
                                )
                              ],
                            ),
                    ),
                  ),
                  if (validate is UploadProductFormError) ...[
                    if (validate.errors.productIcon.isNotEmpty)
                      ErrorText(text: validate.errors.productIcon.first),
                  ]
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _circleAvatar() {
    return const CircleAvatar(
      minRadius: 18.0,
      backgroundColor: whiteColor,
      child: FaIcon(
        FontAwesomeIcons.penToSquare,
        color: blackColor,
        size: 20.0,
      ),
    );
  }
}

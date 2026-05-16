import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/data_provider/remote_url.dart';
import '../../../../data/models/edit/edit_product_model.dart';
import '../../../../logic/cubit/update/update_cubit.dart';
import '../../../../logic/cubit/update/update_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/error_text.dart';

class UpdateImageIconWidget extends StatelessWidget {
  const UpdateImageIconWidget({super.key, required this.editProduct});

  final EditProductModel editProduct;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final uploadBloc = context.read<UpdateCubit>();
    // print('edit-image ${editProduct.product!.thumbnailImage}');
    return BlocBuilder<UpdateCubit, UpdateStateModel>(
      builder: (context, state) {
        final validate = state.updateState;
        final isThumbImage = state.thumbImage.isEmpty;
        final thumbImage = isThumbImage
            ? RemoteUrls.imageUrl(editProduct.product.thumbnailImage)
            : state.thumbImage;
        // print('isThumbImage $isThumbImage');
        // print('thumbimage $thumbImage');

        //productIcon
        final isProductIcon = state.productIcon.isEmpty;
        final productIcon = isProductIcon
            ? RemoteUrls.imageUrl(editProduct.product.productIcon)
            : state.productIcon;
        //print('productIcon $productIcon');
        return Row(
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomImage(
                          fit: BoxFit.cover,
                          path: thumbImage,
                          isFile: state.thumbImage.isNotEmpty,
                        ),
                        Positioned(
                          right: 5.0,
                          top: 5.0,
                          child: GestureDetector(
                            onTap: () async {
                              final thumbnail = await Utils.pickSingleImage();
                              if (thumbnail!.isNotEmpty) {
                                uploadBloc.thumbImageChange(thumbnail);
                              }
                            },
                            child: const CircleAvatar(
                              minRadius: 18.0,
                              backgroundColor: whiteColor,
                              child: FaIcon(
                                FontAwesomeIcons.penToSquare,
                                color: blackColor,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (validate is UpdateFormValidate) ...[
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
                  child: Padding(
                    padding: EdgeInsets.all(Utils.vPadding(size: 6.0)),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomImage(
                          path: productIcon,
                          isFile: state.productIcon.isNotEmpty,
                        ),
                        Positioned(
                          right: 0.0,
                          top: 0.0,
                          child: GestureDetector(
                            onTap: () async {
                              final icon = await Utils.pickSingleImage();
                              if (icon!.isNotEmpty) {
                                uploadBloc.productIconChange(icon);
                              }
                            },
                            child: const CircleAvatar(
                              minRadius: 18.0,
                              backgroundColor: whiteColor,
                              child: FaIcon(
                                FontAwesomeIcons.penToSquare,
                                color: blackColor,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),

                        //Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                if (validate is UpdateFormValidate) ...[
                  if (validate.errors.productIcon.isNotEmpty)
                    ErrorText(text: validate.errors.productIcon.first),
                ]
              ],
            ),
          ],
        );
      },
    );
  }
}

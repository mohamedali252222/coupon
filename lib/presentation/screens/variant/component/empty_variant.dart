import 'package:flutter/material.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../widget/custom_image.dart';
import '../../../widget/custom_text.dart';
import 'variant_app_bar.dart';

class EmptyVariant extends StatelessWidget {
  const EmptyVariant({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // height: size.height,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: size.height / 6.0),
          const CustomImage(path: KImages.emptyVariant),
          const SizedBox(height: 18.0),
          Text(
            'No Variant Found',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20.0),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton.icon(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                splashFactory: NoSplash.splashFactory,
                minimumSize: MaterialStateProperty.all(
                    const Size(double.infinity, 54.0)),
                backgroundColor: MaterialStateProperty.all(primaryColor)),
            onPressed: () => createVariant(context, productId),
            icon: const Icon(
              Icons.add,
              color: whiteColor,
            ),
            label: const CustomText(
              text: 'Add variant',
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

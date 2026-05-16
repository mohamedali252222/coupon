
import 'dart:ui';

import 'package:alas_mart/presentation/utils/constraints.dart';
import 'package:alas_mart/presentation/widget/custom_image.dart';
import 'package:flutter/material.dart';

import '../utils/k_images.dart';
import '../utils/utils.dart';



class LoaderCircle extends StatelessWidget {
  const LoaderCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const SizedBox(),
          ),
        ),
        Container(
          height: ScreenSize(context).block * 20,
          width: ScreenSize(context).block * 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              height: ScreenSize(context).block * 15,
              width: ScreenSize(context).block * 15,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const CustomImage(path: KImages.appLogo)
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 2,
          left: 2,
          right: 2,
          bottom: 2,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            backgroundColor: primaryColor,
          ),
        ),
      ],
    );
  }
}
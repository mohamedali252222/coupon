import 'package:alas_mart/presentation/utils/utils.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF0D25FF);
// const primaryColor = Color(0xFF2969FF);
const secondaryColor = Color(0xFFFE9900);
const yellowGradient = Color(0xFFF9B546);
Color homeBgColor = const Color(0xFFE6E6E6).withOpacity(0.5);
const blackColor = Color(0xFF061533);
const grayColor = Color(0xFF535769);
const grayColor2 = Color(0xFFF5F5F5);
const blueGrayColor = Color(0xFF162B49);
const textColor = Color(0xFF333333);
Color hintTextColor = const Color(0xFF000000).withOpacity(0.2);

const greenColor = Color(0xFF22C55E);
const blueColor = Color(0xFF3266CC);
const redColor = Color(0xFFF54748); //Color(0xFFDC3811);
const whiteColor = Color(0xFFFFFFFF);
const scaffoldBgColor = Color(0xFFF9F9F9);
const fillColor = Color(0xFFF5F5F5);
const Color borderColor = Color(0xFFF0F0F0);
const Color borderColor2 = Color(0xFfF0E8F5);

const kDuration = Duration(microseconds: 300);

const Color transparent = Colors.transparent;

const List<Color> gradientColors = [Color(0xFF1000FF), Color(0xFF0086FF)];
LinearGradient linearGradient = const LinearGradient(
  colors: gradientColors,
  begin: Alignment(0.80, -0.60),
  end: Alignment(-0.8, 0.6),
);

LinearGradient linearGradient2 = const LinearGradient(
  begin: Alignment(0.53, -0.85),
  end: Alignment(-0.53, 0.85),
  colors: [Color(0xFFF9B546), Color(0xFFF4642C)],
);

Widget itemSpace = Utils.verticalSpace(16.0);
Widget sectionSpace = Utils.verticalSpace(25.0);

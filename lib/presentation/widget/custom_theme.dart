import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';

class MyTheme {
  static final borderRadius = BorderRadius.circular(10.0);
  static final theme = ThemeData(
      //brightness: Brightness.light,
      primaryColor: whiteColor,
      scaffoldBackgroundColor: scaffoldBgColor,
      // bottomSheetTheme: const BottomSheetThemeData(backgroundColor: whiteColor),
      // colorScheme: const ColorScheme.light(secondary: lightningYellowColor),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBgColor,
        centerTitle: true,
        titleTextStyle: GoogleFonts.rubik(
            color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: blackColor),
        elevation: 0,
      ),
      textTheme: GoogleFonts.rubikTextTheme(
        TextTheme(
          bodySmall: GoogleFonts.rubik(fontSize: 12, height: 1.83),
          bodyLarge: GoogleFonts.rubik(
              fontSize: 16, fontWeight: FontWeight.w500, height: 1.375),
          bodyMedium: GoogleFonts.rubik(fontSize: 14, height: 1.5714),
          labelLarge: GoogleFonts.rubik(
              fontSize: 16, height: 2, fontWeight: FontWeight.w600),
          titleLarge: GoogleFonts.rubik(
              fontSize: 16, height: 2, fontWeight: FontWeight.w600),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 64),
          backgroundColor: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
            shadowColor: MaterialStatePropertyAll(transparent),
            elevation: MaterialStatePropertyAll(0.0),
            iconSize: MaterialStatePropertyAll(20.0),
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStatePropertyAll(
              (transparent),
            ),
            padding: MaterialStatePropertyAll(EdgeInsets.zero)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 3,
        backgroundColor: whiteColor,
        showUnselectedLabels: true,
        selectedLabelStyle:
            GoogleFonts.rubik(fontSize: 14, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            GoogleFonts.rubik(fontSize: 14, fontWeight: FontWeight.w400),
        selectedItemColor: const Color(0xFF333333),
        unselectedItemColor: const Color(0xFF606060),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        hintStyle: GoogleFonts.rubik(
          fontWeight: FontWeight.w400,
          fontSize: 18.0,
          color: grayColor,
        ),
        labelStyle: GoogleFonts.rubik(
          fontWeight: FontWeight.w400,
          fontSize: 18.0,
          color: hintTextColor,
        ),
        contentPadding: Utils.symmetric(v: 18.0),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: fillColor,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: blackColor,
        selectionColor: blackColor,
        selectionHandleColor: blackColor,
      ),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: primaryColor));
}

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' show parse;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:translator/translator.dart';

import '../../data/models/setting/currencies_model.dart';
import '../../logic/bloc/login/login_bloc.dart';
import '../../logic/cubit/currency/currency_cubit.dart';
import '../../logic/cubit/setting/website_setup_cubit.dart';
import '../widget/custom_text.dart';
import 'constraints.dart';

class Utils {
  static Future<bool> getStoragePermission(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
       print('permission denied');
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }


  static Future<bool> getStoragePermissions() async {
    debugPrint('version ${Platform.operatingSystemVersion}');
    // debugPrint('version ${}');
    // if (Platform.isAndroid && Platform.operatingSystemVersion == '29.0') {
    //   debugPrint('version-29.0 ${Platform.operatingSystemVersion}');
    // }
    final storagePermission = await Permission.storage.request();
    final manageStoragePermission =
    await Permission.manageExternalStorage.request();

    if (storagePermission.isGranted || manageStoragePermission.isGranted) {
      return true;
    } else if (storagePermission.isPermanentlyDenied ||
        manageStoragePermission.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return false;
    }
  }




  static final _selectedDate = DateTime.now();

  static final _initialTime = TimeOfDay.now();

  static String convertLanguage(String text) {
    return utf8.decode(text.runes.toList());
  }




  static String htmlTextConverter(String text) {
    var document = parse(text);
    String convertedText = parse(document.body!.text).documentElement!.text;
    return convertedText;
  }

  static Future<String> translateLocally(
      BuildContext context, String text) async {
    final loginBloc = context.read<LoginBloc>().state.languageCode;
    GoogleTranslator googleTranslate = GoogleTranslator();
    Translation translate =
        await googleTranslate.translate(text, from: 'auto', to: loginBloc);
    final localText = translate.text;
    debugPrint('convertLocalText $localText');
    return localText;
  }

  static String convertToSlug(String input) {
    // Replace spaces and special characters with hyphens and lowercase the string
    return input.toLowerCase().replaceAll(RegExp(r'[^a-zA-Z\d]+'), '-');
  }

  static Widget convertedText(BuildContext context, String text) {
    return FutureBuilder<String>(
      future: Utils.translateLocally(context, text),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('');
        } else if (snapshot.hasError) {
          debugPrint('Error: ${snapshot.error}');
          return CustomText(
            text: text,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          );
        } else {
          return CustomText(
            text: snapshot.data ?? text,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          );
        }
      },
    );
  }

  static String afterPrice = 'right';

  static String afterPriceWithSpace = 'left_to_right';

  static String convertMulCurrency(
      var price, BuildContext context, CurrenciesModel currencies,
      [int radix = 1]) {
    if (currencies.status == 1 &&
        (currencies.currencyPosition.toLowerCase() == Utils.afterPrice)) {
      if (price is double) {
        // debugPrint('double-price $price');
        final result = price * currencies.currencyRate;
        return '${result.toStringAsFixed(radix)}${currencies.currencyIcon}';
      }
      if (price is String) {
        // debugPrint('String-price $price');
        final r = double.tryParse(price) ?? 0.0;
        final p = r * currencies.currencyRate;
        return '${p.toStringAsFixed(radix)}${currencies.currencyIcon}';
      }
      if (price is int) {
        // debugPrint('int-price $price');
        final p = price * currencies.currencyRate;
        return '${p.toStringAsFixed(radix)}${currencies.currencyIcon}';
      } else {
        // debugPrint('other-price $price');
        return '${price * currencies.currencyRate.toStringAsFixed(radix)}${currencies.currencyIcon}';
      }
    } else {
      if (price is double) {
        final result = price * currencies.currencyRate;
        return '${currencies.currencyIcon}${result.toStringAsFixed(radix)}';
      }
      if (price is String) {
        final r = double.tryParse(price) ?? 0.0;
        final p = r * currencies.currencyRate;
        return '${currencies.currencyIcon}${p.toStringAsFixed(radix)}';
      }
      if (price is int) {
        debugPrint('int-price $price');
        final p = price * currencies.currencyRate;
        return '${currencies.currencyIcon}${p.toStringAsFixed(radix)}';
      }
      return '${currencies.currencyIcon}${price * currencies.currencyRate.toStringAsFixed(radix)}';
    }
  }

  static String formatPrice(BuildContext context, var price, [int radix = 1]) {
    final cCubit = context.read<CurrencyCubit>();
    final sCubit = context.read<WebsiteSetupCubit>();
    if (cCubit.state.currencies.isNotEmpty) {
      return Utils.convertMulCurrency(
          price, context, cCubit.state.currencies.first, radix);
    } else {
      if (sCubit.setting != null &&
          sCubit.setting!.setting!.currencyIcon.isNotEmpty) {
        String currency = sCubit.setting!.setting!.currencyIcon;
        final p = price.toString();
        return '$currency$p';
      } else {
        final p = price.toString();
        return '\$$p';
      }
    }
  }



  // static String formatPrice(BuildContext context, var price) {
  //   String currencyIcon = '';
  //   String leftPosition = '';
  //   double priceRate = 0.0;
  //   print('currencyIcon $currencyIcon');
  //   print('leftPosition $leftPosition');
  //   final settingCubit = context.read<WebsiteSetupCubit>();
  //   if (settingCubit.setting != null) {
  //     print('setting ${settingCubit.setting}');
  //     final currency = settingCubit.setting!.currencies!;
  //     if (currency.isNotEmpty) {
  //       for (int i = 0; i < currency.length; i++) {
  //         if (currency[i].isDefault == 'Yes') {
  //           currencyIcon = currency[i].currencyIcon;
  //           leftPosition = currency[i].currencyPosition;
  //           priceRate = currency[i].currencyRate;
  //           debugPrint('currencyIcon $currencyIcon');
  //           debugPrint('leftPosition $leftPosition');
  //           debugPrint('priceRate $priceRate');
  //         }
  //       }
  //     } else {
  //       currencyIcon = '\$';
  //       leftPosition = 'left';
  //       priceRate = 1.0;
  //     }
  //   }
  //   //debugPrint('priceRateeeeeeee $priceRate');
  //   if (price is double) {
  //     double result = price * priceRate;
  //     print('double-price-rate $result');
  //     if (leftPosition == 'left') {
  //       return '$currencyIcon${result.toStringAsFixed(1)}';
  //     } else {
  //       return '${result.toStringAsFixed(1)}$currencyIcon';
  //     }
  //   } else if (price is String) {
  //     final result = double.parse(price) * priceRate;
  //     print('String-price-rate $result');
  //     final p = double.tryParse(result.toString()) ?? 0;
  //     if (leftPosition == 'left') {
  //       return '$currencyIcon${p.toStringAsFixed(0)}';
  //     } else {
  //       return '${p.toStringAsFixed(0)}$currencyIcon';
  //     }
  //   } else if (price is int) {
  //     double result = price * priceRate;
  //     print('int-price-rate $result');
  //     if (leftPosition == 'left') {
  //       return '$currencyIcon${result.toStringAsFixed(0)}';
  //     } else {
  //       return '${result.toStringAsFixed(0)}$currencyIcon';
  //     }
  //   }
  //   print('default-price-rate $price');
  //   return '$currencyIcon${price.toStringAsFixed(0) * priceRate}';
  // }

  static Future<String?> pickSingleImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  static Future<String?> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    if (result != null && result.files.single.path!.isNotEmpty) {
      File file = File(result.files.single.path!);
      debugPrint('file-path ${file.path}');
      return file.path;
    } else {
      debugPrint('file path not found');
      return null;
    }
  }

  // static Future<List<String>> pickMultipleImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final List<String> imageList = [];
  //   final List<XFile?> images = await picker.pickMultiImage();
  //   if (images.isNotEmpty) {
  //     // imageList.addAll(images);
  //     //  return images.map((e) => imageList.add(e!.path)).toList();
  //     for (var i in images) {
  //       imageList.add(i!.path.toString());
  //     }
  //     debugPrint('picked images: ${imageList.length}');
  //     return imageList;
  //   }
  //   return [];
  // }

  static String formatDate(var date) {
    late DateTime _dateTime;
    if (date is String) {
      _dateTime = DateTime.parse(date);
    } else {
      _dateTime = date;
    }

    // return DateFormat.MMMEd().format(_dateTime.toLocal());
    return DateFormat.yMMMMd().format(_dateTime.toLocal());
  }

  static String timeAgo(var date) {
    late DateTime _dateTime;
    if (date is String) {
      _dateTime = DateTime.now();
    } else {
      _dateTime = date;
    }

    // return DateFormat.MMMEd().format(_dateTime.toLocal());
    return DateFormat.jm().format(_dateTime);
  }

  static Future<String> getDir() async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  static status(int i) {
    switch (i) {
      case 1:
        return 'Active';
      case 2:
        return 'Pending';
      case 3:
        return 'Completed';
      case 4:
        return 'Rejected';
      default:
        return 'No Status';
    }
  }

  static String convertToAgo(String? time) {
    Duration diff = DateTime.now().difference(DateTime.parse(time!));

    try {
      if (diff.inDays >= 1) {
        return '${diff.inDays} days ago';
      } else if (diff.inHours >= 1) {
        return '${diff.inHours} hours ago';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes} minutes ago';
      } else if (diff.inSeconds >= 1) {
        return '${diff.inSeconds} seconds ago';
      } else {
        return 'Just Now';
      }
    } catch (e) {
      return '';
    }
  }

  static Widget verticalSpace(double size) {
    return SizedBox(height: size.h);
  }

  static Widget horizontalSpace(double size) {
    return SizedBox(width: size.w);
  }

  static double hSize(double size) {
    return size.w;
  }

  static double vSize(double size) {
    return size.h;
  }

  static EdgeInsets symmetric({double h = 20.0, v = 0.0}) {
    return EdgeInsets.symmetric(
        horizontal: Utils.hPadding(size: h), vertical: Utils.vPadding(size: v));
  }

  static double radius(double radius) {
    return radius.sp;
  }

  static BorderRadius borderRadius({double r = 10.0}) {
    return BorderRadius.circular(Utils.radius(r));
  }

  static EdgeInsets all({double value = 0.0}) {
    return EdgeInsets.all(value.dm);
  }

  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(
        left: left.w, top: top.h, right: right.w, bottom: bottom.h);
  }

  static double vPadding({double size = 20.0}) {
    return size.h;
  }

  static double hPadding({double size = 20.0}) {
    return size.w;
  }

  static double toDouble(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static double toInt(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<DateTime?> selectDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2050),
      );

  static Future<TimeOfDay?> selectTime(BuildContext context) =>
      showTimePicker(context: context, initialTime: _initialTime);

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static loadingDialog(
    BuildContext context, {
    bool barrierDismissible = false,
  }) {
    // closeDialog(context);
    showCustomDialog(
      context,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: primaryColor),
              SizedBox(width: 15),
              Text('Please wait a moment')
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static bool _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.pop(context);
    }
  }

  static Future showCustomDialog(
    BuildContext context, {
    Widget? child,
    bool barrierDismissible = false,
    Color bgColor = whiteColor,
    double? padding,
  }) {
    padding = 10.0;
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: bgColor,
          insetPadding: Utils.symmetric(h: padding!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
      },
    );
  }

  static void errorSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(errorMsg, style: const TextStyle(color: Colors.red)),
        ),
      );
  }

  static void showSnackBar(BuildContext context, String msg,
      [Color textColor = whiteColor]) {
    final snackBar = SnackBar(
        duration: const Duration(milliseconds: 800),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void serviceUnAvailable(BuildContext context, String msg,
      [Color textColor = Colors.white]) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(milliseconds: 500),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSnackBarWithAction(
      BuildContext context, String msg, VoidCallback onPress,
      [Color textColor = primaryColor]) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: msg, color: whiteColor),
          GestureDetector(
            onTap: onPress,
            child: Container(
              padding: Utils.symmetric(v: 6.0, h: 14.0),
              decoration: BoxDecoration(
                borderRadius: Utils.borderRadius(r: 6.0),
                border: Border.all(color: whiteColor),
              ),
              child: const CustomText(text: 'Add Variant', color: whiteColor),
            ),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class InfoLabel extends StatelessWidget {
  const InfoLabel({
    Key? key,
    this.label,
    this.text,
  }) : super(key: key);
  final String? label;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "${label!} : ",
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400, color: blackColor, fontSize: 14.0),
        children: [
          TextSpan(
            text: text!,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, color: blackColor, fontSize: 16.0),
          )
        ],
      ),
    );
  }
}

class ScreenSize {
  BuildContext context;
  ScreenSize(this.context);
  double get mainHeight => MediaQuery.of(context).size.height;
  double get mainWidth => MediaQuery.of(context).size.width;
  double get block => mainWidth / 100;
}

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/presentation/utils/constraints.dart';
import '../../../data/data_provider/remote_url.dart';
import '../../../data/models/cart/coupon_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/add_to_cart/add_to_cart_cubit.dart';
import '../../routes/routes_name.dart';
import '../../utils/utils.dart';

class PayStackPaymentScreen extends StatefulWidget {
  const PayStackPaymentScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<PayStackPaymentScreen> createState() => _FlutterWaveState();
}

class _FlutterWaveState extends State<PayStackPaymentScreen> {
  double value = 0.0;

  bool _canRedirect = true;

  bool _isLoading = true;
  CouponDto? couponDto;
  String couponSlug = "";
  String newUrl = "";

  late WebViewController controllerGlobal;

  @override
  void initState() {
    getCouponDiscount();
    initialController();
    super.initState();
  }

  initialController() {
    controllerGlobal = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(whiteColor)
      ..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              value = progress / 100;
            });
            log("WebView is loading (progress : $progress%)");
          },
          onPageStarted: (String url) {
            log('Page started loading: $url');
            setState(() {
              _isLoading = true;
            });
            log("printing urls $url");
            _redirect(url);
          },
          onPageFinished: (String url) {
            log('Page finished loading: $url');
            setState(() {
              _isLoading = false;
            });
            _redirect(url);
          },
          onUrlChange: (url) {}))
      ..loadRequest(Uri.parse(widget.url));
  }

  void getCouponDiscount() {
    final langCode = context.read<LoginBloc>().state.languageCode;
    print('languageCode $langCode');
    couponDto = context.read<AddToCartCubit>().couponDto;
    if (couponDto != null) {
      debugPrint('couponDto $couponDto');
      couponSlug =
          "&coupon_code=${couponDto!.couponName}&coupon_amount=${couponDto!.discount}&lang_code=$langCode";
    }
  }

  //"&output=embed"
  @override
  Widget build(BuildContext context) {
    newUrl = widget.url + couponSlug;
    print('new-url $newUrl');
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text("Paystack Payment"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => _exitApp(context),
          ),
          backgroundColor: whiteColor,
        ),
        body: Column(
          children: [
            if (_isLoading)
              Center(
                child: LinearProgressIndicator(
                  value: value,
                ),
              ),
            Expanded(
              child: WebViewWidget(controller: controllerGlobal),
            ),
            // Expanded(child: oldWebViewController())
          ],
        ),
      ),
    );
  }

  void _redirect(String url) {
    if (_canRedirect) {
      bool isSuccess = url.contains('/payment-api/webview-success-payment') &&
          url.contains(RemoteUrls.rootUrl);
      bool isFailed = url.contains('fail') && url.contains(RemoteUrls.rootUrl);
      bool isCancel = url.contains('/order-fail-url-for-mobile-app') &&
          url.contains(RemoteUrls.rootUrl);
      if (isSuccess || isFailed || isCancel) {
        _canRedirect = false;
      }
      if (isSuccess) {
        getData();
      } else if (isFailed || isCancel) {
        Utils.errorSnackBar(context, 'Payment cancelled');
        Navigator.pop(context);
        return;
      } else {
        log("Encountered problem");
      }
    }
  }

  void getData() {
    controllerGlobal
        .runJavaScriptReturningResult("document.body.innerText")
        //.runJavascriptReturningResult("document.body.innerText")
        .then(
      (data) {
        var decodedJSON = jsonDecode(data.toString());
        var responseJSON = jsonDecode(decodedJSON);
        log(decodedJSON, name: 'FlutterWaveScreen');
        if (responseJSON["result"] == false) {
          Utils.errorSnackBar(context, responseJSON["message"]);
        } else if (responseJSON["result"] == true) {
          Utils.showSnackBar(context, responseJSON["message"]);
        }
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.downloadedFileScreen, (route) {
          if (route.settings.name == RouteNames.mainScreen) {
            return true;
          }
          return false;
        });
        Utils.showSnackBar(context, responseJSON["message"]);
      },
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      return true;
    }
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/constraints.dart';
import '../../../widget/custom_sliver_app_bar.dart';
import '../../../widget/custom_text.dart';

class SpecialOfferScreen extends StatefulWidget {
  const SpecialOfferScreen({super.key, required this.url});

  final String url;

  @override
  State<SpecialOfferScreen> createState() => _SpecialOfferScreenState();
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {
  late WebViewController controller;
  double value = 0.0;
  bool loading = true;

  late WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    initialController();
  }

  final headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

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
        onPageFinished: (String? finish) {
          print('page loaded');
          setState(() {
            loading = false;
          });
        },
        onPageStarted: (String url) {
          log('Page started loading: $url');
          setState(() {
            loading = true;
          });
        },
      ))
      ..enableZoom(true)
      ..loadRequest(
        Uri.parse(widget.url),
        headers: headers,
      );
  }

  @override
  Widget build(BuildContext context) {
    print('value $value');
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Special Offer',
          color: blackColor,
          fontSize: 20.0,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (loading) ...[
            const Center(
              child: LinearProgressIndicator(),
            ),
          ] else ...[
            Expanded(
              child: WebViewWidget(controller: controllerGlobal),
            ),
          ]
        ],
      ),
    );
  }

  CustomScrollView buildCustomScrollView(Map<String, String> headers) {
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'Special Offer',
          iconColor: whiteColor,
          isGradientBg: true,
        ),
        SliverToBoxAdapter(
          child: WebViewWidget(
            controller: controller
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..enableZoom(true)
              ..setBackgroundColor(whiteColor)
              ..setNavigationDelegate(
                NavigationDelegate(
                    onProgress: (int progress) {},
                    onPageStarted: (String url) => print('start-url $url'),
                    onPageFinished: (String url) {
                      print('url-finish $url');
                    },
                    onUrlChange: (UrlChange url) =>
                        print('url-changeing $url')),
              )
              ..loadRequest(
                Uri.parse(widget.url),
                headers: headers,
                method: LoadRequestMethod.get,
              ),
          ),
        ),
      ],
    );
  }
}

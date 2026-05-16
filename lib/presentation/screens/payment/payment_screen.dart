import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/remote_url.dart';
import '../../../data/models/payment/payment_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../logic/cubit/payment/payment_cubit.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loading_widget.dart';
import '../authentication/component/custom_authentication_widget.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentCubit = context.read<PaymentCubit>();
    return Scaffold(
      body: BlocConsumer<PaymentCubit, LanguageCodeState>(
        listener: (context, state) {
          final payment = state.paymentState;
          if (payment is PaymentStateInfoError) {
            if (payment.statusCode == 503 || paymentCubit.payment == null) {
              paymentCubit.getPaymentPageInformation();
            }
          }
        },
        builder: (context, state) {
          final payment = state.paymentState;
          if (payment is PaymentStateInfoLoading) {
            return const LoadingWidget();
          } else if (payment is PaymentStateInfoError) {
            if (payment.statusCode == 503) {
              if (paymentCubit.payment != null) {
                return PaymentInfoLoadedWidget(payment: paymentCubit.payment!);
              }
            } else {
              return const FetchErrorText(text: 'Network problem');
            }
            return FetchErrorText(text: payment.message);
          } else if (payment is PaymentStateInfoLoaded) {
            return PaymentInfoLoadedWidget(payment: payment.payment);
          }
          if (paymentCubit.payment != null) {
            return PaymentInfoLoadedWidget(payment: paymentCubit.payment!);
          } else {
            return const FetchErrorText(text: 'Something went wrong!');
          }
        },
      ),
    );
  }
}

class PaymentInfoLoadedWidget extends StatelessWidget {
  const PaymentInfoLoadedWidget({super.key, required this.payment});

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final token = context.read<LoginBloc>().userInformation!.accessToken;
    print('user-accessToken $token');
    return CustomAuthenticationWidget(
        height: size.height * 0.16,
        isShowBackButton: false,
        topChild: _buildPaymentAppBar(size),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: Utils.only(bottom: size.height * 0.2),
          shrinkWrap: true,
          children: [
            const CustomText(
              text: 'Choose your Payment Method',
              fontWeight: FontWeight.w500,
              color: blackColor,
              fontSize: 20.0,
            ),
            Utils.verticalSpace(10.0),
            SinglePaymentCard(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.stripePaymentScreen),
              icon: payment.stripe!.image,
              status: payment.stripe!.status,
              // icon: KImages.paymentIcon01,
            ),
            SinglePaymentCard(
              onTap: () {
                final url = RemoteUrls.payWithPaypal(token);
                Navigator.pushNamed(context, RouteNames.paypalPaymentScreen,
                    arguments: url);
              },
              icon: payment.payPal!.image,
              status: payment.payPal!.status,
              // icon: KImages.paymentIcon02,
            ),
            SinglePaymentCard(
              onTap: () {
                final url = RemoteUrls.payWithMolli(token);
                Navigator.pushNamed(context, RouteNames.molliPaymentScreen,
                    arguments: url);
              },
              icon: payment.molliPayStack!.mollieImage,
              status: payment.molliPayStack!.mollieStatus,
              // icon: KImages.paymentIcon03,
            ),
            SinglePaymentCard(
              onTap: () {
                final url = RemoteUrls.payWithPayStack(token);
                Navigator.pushNamed(context, RouteNames.payStackPaymentScreen,
                    arguments: url);
              },
              icon: payment.molliPayStack!.paystackImage,
              status: payment.molliPayStack!.paystackStatus,
              // icon: KImages.paymentIcon04,
            ),
            SinglePaymentCard(
              onTap: () {
                final url = RemoteUrls.payWithInstamojo(token);
                Navigator.pushNamed(context, RouteNames.instamojoPaymentScreen,
                    arguments: url);
              },
              icon: payment.instamojo!.image,
              status: payment.instamojo!.status,
              // icon: KImages.paymentIcon05,
            ),
            SinglePaymentCard(
              onTap: () {
                final url = RemoteUrls.payWithRazorpay(token);
                Navigator.pushNamed(context, RouteNames.razorpayPaymentScreen,
                    arguments: url);
              },
              icon: payment.razorPay!.image,
              status: payment.razorPay!.status,
              // icon: KImages.paymentIcon06,
            ),
            SinglePaymentCard(
              onTap: () {
                final url = RemoteUrls.payWithFlutterWave(token);
                Navigator.pushNamed(
                    context, RouteNames.flutterWavePaymentScreen,
                    arguments: url);
              },
              icon: payment.flutterWave!.logo,
              status: payment.flutterWave!.status,
              // icon: KImages.paymentIcon07,
            ),
            // SinglePaymentCard(
            //   onTap: () {
            //     final url = RemoteUrls.payWithSSl(token);
            //     Navigator.pushNamed(context, RouteNames.sslPaymentScreen,
            //         arguments: url);
            //   },
            //   icon: payment.sslcommerz!.image,
            //   status: payment.sslcommerz!.status,
            //   // icon: KImages.paymentIcon08,
            // ),
            SinglePaymentCard(
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.bankPaymentScreen),
              icon: payment.bankPayment!.image,
              status: payment.bankPayment!.status,
              // icon: KImages.paymentIcon08,
            ),
          ],
        ));
  }

  Widget _buildPaymentAppBar(Size size) {
    return Positioned(
      top: Utils.vSize(size.height * 0.06),
      left: Utils.vSize(size.width * 0.04),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(
            title: 'Payment',
            textColor: whiteColor,
          ),
        ],
      ),
    );
  }
}

class SinglePaymentCard extends StatelessWidget {
  const SinglePaymentCard(
      {Key? key, required this.onTap, required this.icon, required this.status})
      : super(key: key);
  final VoidCallback onTap;
  final String icon;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: status == 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 80.0,
          padding: Utils.symmetric(v: 10.0, h: 0.0),
          margin: Utils.symmetric(v: 12.0, h: 0.0).copyWith(bottom: 0.0),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFDBDBDB)),
            borderRadius: Utils.borderRadius(),
          ),
          child: CustomImage(
            path: RemoteUrls.imageUrl(icon),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

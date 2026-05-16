import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/cart/coupon_model.dart';
import '../../../logic/bloc/login/login_bloc.dart';
import '../../../logic/cubit/add_to_cart/add_to_cart_cubit.dart';
import '../../../logic/cubit/stripe_payment/stripe_payment_cubit.dart';
import '../../../logic/cubit/stripe_payment/stripe_payment_state_model.dart';
import '../../routes/routes_name.dart';
import '../../utils/constraints.dart';
import '../../utils/utils.dart';
import '../../widget/custom_text.dart';
import '../../widget/error_text.dart';
import '../../widget/primary_button.dart';

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({Key? key}) : super(key: key);

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  CouponDto? couponDto;
  String couponSlug = "";

  @override
  void initState() {
    getCouponDiscount();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final stripePayment = context.read<StripePaymentCubit>();
    const spacer = SizedBox(height: 20.0);
    return Scaffold(
      backgroundColor: whiteColor,
      // appBar: const CustomAppBar(
      //   title: 'Stripe Payment',
      //   bgColor: primaryColor,
      //   iconColor: whiteColor,
      //   textColor: whiteColor,
      // ),
      appBar: AppBar(
        title: const CustomText(text: 'Stripe Payment',fontSize: 16,),
      ),
      body: BlocListener<StripePaymentCubit, StripePaymentStateModel>(
        listener: (context, state) {
          final payment = state.paymentState;
          if (payment is StripePaymentLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (payment is StripePaymentError) {
              Utils.errorSnackBar(context, payment.message);
            } else if (payment is StripePaymentLoaded) {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.downloadedFileScreen, (route) {
                if (route.settings.name == RouteNames.mainScreen) {
                  return true;
                }
                return false;
              });
              Utils.showSnackBar(context, payment.message);
              context.read<AddToCartCubit>().removeCoupon();
            }
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            const SizedBox(height: 40.0),
            BlocBuilder<StripePaymentCubit, StripePaymentStateModel>(
              builder: (context, state) {
                final payment = state.paymentState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Card Number'),
                      initialValue: state.cardNumber,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (String text) =>
                          stripePayment.cardNumberChange(text),
                    ),
                    if (payment is StripePaymentFormError) ...[
                      if (payment.errors.cardNumber.isNotEmpty)
                        ErrorText(text: payment.errors.cardNumber.first),
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<StripePaymentCubit, StripePaymentStateModel>(
              builder: (context, state) {
                final payment = state.paymentState;
                return Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(hintText: 'Month'),
                          initialValue: state.month,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (String text) =>
                              stripePayment.monthChange(text),
                        ),
                        if (payment is StripePaymentFormError) ...[
                          if (payment.errors.month.isNotEmpty)
                            ErrorText(text: payment.errors.month.first),
                        ]
                      ],
                    )),
                    const SizedBox(width: 14.0),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(hintText: 'Year'),
                          initialValue: state.year,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (String text) =>
                              stripePayment.yearChange(text),
                        ),
                        if (payment is StripePaymentFormError) ...[
                          if (payment.errors.year.isNotEmpty)
                            ErrorText(text: payment.errors.year.first),
                        ]
                      ],
                    )),
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<StripePaymentCubit, StripePaymentStateModel>(
              builder: (context, state) {
                final payment = state.paymentState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'CVC'),
                      initialValue: state.cvc,
                      keyboardType: TextInputType.number,
                      onChanged: (String text) => stripePayment.cvcChange(text),
                    ),
                    if (payment is StripePaymentFormError) ...[
                      if (payment.errors.cvc.isNotEmpty)
                        ErrorText(text: payment.errors.cvc.first),
                    ]
                  ],
                );
              },
            ),
            spacer,
            PrimaryButton(
                text: 'Payment Now',
                onPressed: () {
                  Utils.closeKeyBoard(context);
                  stripePayment.stripePayment(couponSlug);
                })
          ],
        ),
      ),
    );
  }
}

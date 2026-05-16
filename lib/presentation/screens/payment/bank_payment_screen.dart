import 'package:flutter/material.dart';

import '/presentation/utils/utils.dart';
import '/presentation/widget/primary_button.dart';
import '../../../data/models/cart/coupon_model.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../state_packages_name.dart';
import '../../routes/routes_name.dart';
import '../../widget/custom_text.dart';
import '../../widget/error_text.dart';

class BankPaymentScreen extends StatefulWidget {
  const BankPaymentScreen({Key? key}) : super(key: key);

  @override
  State<BankPaymentScreen> createState() => _BankPaymentScreenState();
}

class _BankPaymentScreenState extends State<BankPaymentScreen> {
  CouponDto? couponDto;
  String couponSlug = "";

  @override
  void initState() {
    getCouponDiscount();
    super.initState();
  }

  @override
  void dispose() {
    context.read<PaymentCubit>().transactionController.dispose();
    super.dispose();
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
    final paymentCubit = context.read<PaymentCubit>();
    return Scaffold(
      // appBar: const CustomAppBar(
      //   title: 'Bank Payment',
      //   bgColor: primaryColor,
      //   iconColor: whiteColor,
      //   textColor: whiteColor,
      // ),
      appBar: AppBar(
        title: const CustomText(text: 'Bank Payment'),
      ),
      body: BlocListener<PaymentCubit, LanguageCodeState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          final payment = state.paymentState;
          if (payment is PaymentStateInfoLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (payment is PaymentStateInfoError) {
              Utils.errorSnackBar(context, payment.message);
            } else if (payment is BankPaymentLoaded) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.downloadedFileScreen, (route) {
                if (route.settings.name == RouteNames.mainScreen) {
                  return true;
                }
                return false;
              });
              // Navigator.of(context).pop();
              context.read<AddToCartCubit>().removeCoupon();
              paymentCubit.transactionController.clear();
              Utils.showSnackBar(context, payment.message);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Utils.verticalSpace(25.0),
              BlocBuilder<PaymentCubit, LanguageCodeState>(
                builder: (context, state) {
                  final payment = state.paymentState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: paymentCubit.transactionController,
                        maxLines: 10,
                        decoration: InputDecoration(
                            hintText:
                                paymentCubit.payment!.bankPayment!.accountInfo),
                      ),
                      if (payment is PaymentStateFormError) ...[
                        if (payment.errors.tnxInfo.isNotEmpty)
                          ErrorText(text: payment.errors.tnxInfo.first),
                      ]
                    ],
                  );
                },
              ),
              const SizedBox(height: 20.0),
              PrimaryButton(
                text: 'Payment Now',
                onPressed: () {
                  Utils.closeKeyBoard(context);
                  paymentCubit.bankPayment(couponSlug);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

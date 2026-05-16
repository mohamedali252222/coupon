import 'package:flutter/material.dart';

import '../../../data/models/withdraw/seller_withdraw_info.dart';
import '../../../logic/cubit/language_code_state.dart';
import '../../../logic/cubit/withdraw/create_withdraw/create_withdraw_state_model.dart';
import '../../../state_packages_name.dart';
import '../../utils/constraints.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_sliver_app_bar.dart';
import '../../widget/custom_text.dart';
import '../../widget/fetch_error_text.dart';
import '../../widget/loader_circle.dart';
import '../../widget/loading_widget.dart';
import 'component/withdraw_component.dart';
import 'component/withdraw_dialog.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final withdrawCubit = context.read<SellerWithdrawCubit>();
    withdrawCubit.getSellerWithdraw();
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: BlocListener<CreateWithdrawCubit, CreateWithdrawStateModel>(
        listener: (context, state) {
          final withdraw = state.withdrawState;
          if (withdraw is CreateWithdrawLoaded) {
            withdrawCubit.getSellerWithdraw();
          }
        },
        child: BlocConsumer<SellerWithdrawCubit, LanguageCodeState>(
          listener: (context, state) {
            final withdraw = state.sellerWithdrawState;
            if (withdraw is SellerWithdrawError) {
              if (withdrawCubit.withdrawInfo == null ||
                  withdraw.statusCode == 503) {
                withdrawCubit.getSellerWithdraw();
              }
            }
          },
          builder: (context, state) {
            final withdraw = state.sellerWithdrawState;
            if (withdraw is SellerWithdralLoading) {
              return const Center(child: LoaderCircle());
            } else if (withdraw is SellerWithdrawError) {
              if (withdraw.statusCode == 503) {
                if (withdrawCubit.withdrawInfo != null) {
                  return LoadedSellerWithdraw(
                      withdrawInfo: withdrawCubit.withdrawInfo!);
                }
              } else {
                return const FetchErrorText(text: 'Network problem');
              }
              return FetchErrorText(text: withdraw.message);
            } else if (withdraw is SellerWithdrawLoaded) {
              return LoadedSellerWithdraw(
                  withdrawInfo: withdraw.sellerWithdrawInfo);
            }
            if (withdrawCubit.withdrawInfo != null) {
              return LoadedSellerWithdraw(
                  withdrawInfo: withdrawCubit.withdrawInfo!);
            } else {
              return const FetchErrorText(text: 'Something went wrong!');
            }
          },
        ),
      ),
    );
  }
}

class LoadedSellerWithdraw extends StatelessWidget {
  const LoadedSellerWithdraw({super.key, required this.withdrawInfo});

  final SellerWithdrawInfo withdrawInfo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(
          title: 'Wallet',
          iconColor: whiteColor,
          isGradientBg: true,
        ),
        LoadedBalanceWidget(balance: withdrawInfo.currentBalance),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _balance(KImages.totalEarning, 'Total Withdraw',
                  Utils.formatPrice(context, withdrawInfo.totalWithdraw)),
              //Utils.horizontalSpace(16),
              _balance(KImages.totalEarning2, 'Total Earning',
                  Utils.formatPrice(context, withdrawInfo.totalBalance)),
            ],
          ),
        ),
        if (withdrawInfo.withdraws.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Container(
              width: Utils.hSize(size.width),
              height: Utils.vSize(size.height * 0.52),
              padding: Utils.all(value: 16.0),
              margin: Utils.symmetric(h: 16.0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: Utils.borderRadius(r: 6.0),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'My Withdraws',
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0,
                    color: primaryColor,
                  ),
                  Utils.verticalSpace(12.0),
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: Utils.only(bottom: 30.0),
                        scrollDirection: Axis.vertical,
                        physics: const ClampingScrollPhysics(),
                        itemCount: withdrawInfo.withdraws.length,
                        itemBuilder: (context, index) {
                          final withdraw =
                              withdrawInfo.withdraws.reversed.toList()[index];
                          final border = withdrawInfo.withdraws.length - 1;
                          return WithdrawComponent(
                            showDivider: index != border,
                            model: withdraw,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          const SliverToBoxAdapter(
            child: Center(
              child: CustomText(
                text: 'No transaction found!',
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _balance(String icon, String title, String balance) {
    return Container(
      alignment: Alignment.center,
      padding: Utils.all(value: 24.0),
      margin: Utils.only(top: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 84,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(
            path: icon,
          ),
          Utils.verticalSpace(6.0),
          CustomText(
            text: title,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: grayColor,
          ),
          Utils.verticalSpace(6.0),
          CustomText(
            text: balance,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: blackColor,
          )
        ],
      ),
    );
  }
}

class LoadedBalanceWidget extends StatelessWidget {
  const LoadedBalanceWidget({super.key, required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: Utils.vSize(120.0),
        alignment: Alignment.center,
        margin: Utils.only(top: 16.0, left: 20.0, right: 20.0),
        padding: Utils.symmetric(h: 16.0),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: Utils.borderRadius(r: 6.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(
                  text: 'Current Balance',
                  fontSize: 12.0,
                  color: whiteColor,
                ),
                Utils.verticalSpace(6.0),
                CustomText(
                  text: Utils.formatPrice(context, balance),
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: whiteColor,
                ),
              ],
            ),
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const WithdrawDialog()),
              child: Container(
                padding: Utils.symmetric(v: 14.0),
                margin: Utils.only(left: 20.0),
                decoration: BoxDecoration(
                  borderRadius: Utils.borderRadius(r: 6.0),
                  gradient: const LinearGradient(
                    begin: Alignment(0.53, -0.85),
                    end: Alignment(-0.53, 0.85),
                    colors: [Color(0xFFF9B546), Color(0xFFF4642C)],
                  ),
                ),
                child: const CustomText(
                  text: 'Withdraw',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

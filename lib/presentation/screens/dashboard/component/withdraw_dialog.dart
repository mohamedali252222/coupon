import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../data/models/withdraw/account_info_model.dart';
import '../../../../data/models/withdraw/method_model.dart';
import '../../../../logic/cubit/language_code_state.dart';
import '../../../../logic/cubit/withdraw/create_withdraw/create_withdraw_state_model.dart';
import '../../../../state_packages_name.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_form.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/error_text.dart';
import '../../../widget/loading_widget.dart';
import '../../../widget/primary_button.dart';

class WithdrawDialog extends StatelessWidget {
  const WithdrawDialog({super.key});

  final _className = 'WithdrawDialog';

  @override
  Widget build(BuildContext context) {
    final withdrawCubit = context.read<CreateWithdrawCubit>();
    final accountCubit = context.read<SingleAccountInfoCubit>();
    final methodList = context.read<SellerWithdrawCubit>().withdrawMethods;
    return Dialog(
      insetPadding: Utils.symmetric(h: 14.0),
      child: MultiBlocListener(
        listeners: [
          BlocListener<CreateWithdrawCubit, CreateWithdrawStateModel>(
            listener: (_, state) {
              final withdraw = state.withdrawState;
              if (withdraw is CreateWithdrawError) {
                Navigator.of(context).pop(true);
                Utils.errorSnackBar(context, withdraw.message);
              } else if (withdraw is CreateWithdrawLoaded) {
                Navigator.of(context).pop(true);
                Utils.showSnackBar(context, withdraw.message);
              }
            },
          ),
          BlocListener<SingleAccountInfoCubit, LanguageCodeState>(
            listener: (context, state) {
              final account = state.accountInfoState;
              if (account is SingleAccountInfoLoading) {
                log(account.toString(), name: _className);
              } else if (account is SingleAccountInfoError) {
                Utils.errorSnackBar(context, account.message);
              } else if (account is SingleAccountInfoLoaded) {
                showAccountInformation(context, account.accountInfo);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: Utils.symmetric(h: 16.0, v: 14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Flexible(
                      fit: FlexFit.loose,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'New Withdraw',
                            fontSize: 20.0,
                            color: blackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.clear,
                        color: redColor,
                      ),
                    )
                  ],
                ),
                Utils.verticalSpace(12.0),
                BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
                  builder: (context, state) {
                    final amount = state.withdrawState;
                    return CustomFormWidget(
                      label: 'Select Method',
                      bottomSpace: 16.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<MethodModel>(
                            hint: const CustomText(
                                text: 'Select Method',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: blueGrayColor),
                            isDense: true,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_outlined,
                                color: blackColor),
                            items: methodList
                                .map<DropdownMenuItem<MethodModel>>(
                                  (MethodModel payment) => DropdownMenuItem(
                                    value: payment,
                                    child: CustomText(
                                      text: payment.name,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: blueGrayColor,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              withdrawCubit.changeMethodId(value.id.toString());
                              accountCubit
                                  .getAccountInformation(value.id.toString());
                            },
                          ),
                          if (amount is CreateWithdrawFormError) ...[
                            if (amount.errors.methodId.isNotEmpty)
                              ErrorText(text: amount.errors.methodId.first)
                          ]
                        ],
                      ),
                    );
                  },
                ),
                BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
                  builder: (context, state) {
                    final amount = state.withdrawState;
                    return CustomFormWidget(
                      label: 'Withdraw amount',
                      bottomSpace: 16.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            initialValue: state.withdrawAmount,
                            onChanged: (String amount) =>
                                withdrawCubit.changeAmount(amount),
                            decoration: const InputDecoration(
                                hintText: 'withdraw amount'),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.deny('a'),
                            ],
                          ),
                          if (amount is CreateWithdrawFormError) ...[
                            if (amount.errors.withdrawAmount.isNotEmpty)
                              ErrorText(
                                  text: amount.errors.withdrawAmount.first)
                          ]
                        ],
                      ),
                    );
                  },
                ),
                BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
                  builder: (context, state) {
                    final amount = state.withdrawState;
                    return CustomFormWidget(
                      label: 'Account Information',
                      bottomSpace: 20.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                hintText: 'Account Information'),
                            keyboardType: TextInputType.text,
                            initialValue: state.accountInfo,
                            onChanged: (String amount) =>
                                withdrawCubit.changeBankInfo(amount),
                            maxLines: 3,
                          ),
                          if (amount is CreateWithdrawFormError) ...[
                            if (amount.errors.accountInfo.isNotEmpty)
                              ErrorText(text: amount.errors.accountInfo.first)
                          ]
                        ],
                      ),
                    );
                  },
                ),
                BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
                  builder: (context, state) {
                    final amount = state.withdrawState;
                    if (amount is CreateWithdrawLoading) {
                      return const LoadingWidget();
                    }
                    return PrimaryButton(
                      text: 'Create Withdraw',
                      onPressed: () {
                        Utils.closeKeyBoard(context);
                        withdrawCubit.createWithdrawMethod();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAccountInformation(BuildContext context, AccountInfoModel accountInfo) {
    const space = SizedBox(height: 6.0);
    return Utils.showCustomDialog(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0)
                .copyWith(top: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Method Information',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 20.0, color: Colors.black),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.clear,
                    color: primaryColor,
                    size: 30.0,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Min Amount'),
                          Text(Utils.formatPrice(
                              context, accountInfo.info!.minAmount)),
                        ],
                      ),
                      space,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Max Amount'),
                          Text(Utils.formatPrice(
                              context, accountInfo.info!.maxAmount)),
                        ],
                      ),
                      space,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Withdraw Charge'),
                          Text('${accountInfo.info!.withdrawCharge}%'),
                        ],
                      ),
                    ],
                  ),
                ),
                space,
                CustomText(
                    text:
                        Utils.htmlTextConverter(accountInfo.info!.description)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

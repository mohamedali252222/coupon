import 'package:flutter/material.dart';

import '../../../../data/models/withdraw/withdraw_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';

class WithdrawComponent extends StatelessWidget {
  const WithdrawComponent(
      {super.key, this.showDivider = true, required this.model});

  final bool showDivider;

  final WithdrawModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: Utils.formatPrice(context, model.totalAmount),
              fontWeight: FontWeight.w700,
              fontSize: 22.0,
              color: blackColor,
            ),
            CustomText(
              text: Utils.formatDate(model.createdAt),
              //text: '20 October, 2023',
              fontSize: 14.0,
              color: grayColor,
            ),
          ],
        ),
        Utils.verticalSpace(2.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              text: 'Transfer Amount',
              fontSize: 14.0,
              color: grayColor,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: Utils.hPadding(size: 10.0),
                  vertical: Utils.vPadding(size: 5.0)),
              decoration: BoxDecoration(
                color: model.status == 1
                    ? greenColor.withOpacity(0.16)
                    : redColor.withOpacity(0.16),
                borderRadius: Utils.borderRadius(r: 25.0),
              ),
              child: Padding(
                  padding: Utils.only(bottom: 4.0),
                  child: CustomText(
                    text: model.status == 1 ? 'Success' : 'Pending',
                    fontSize: 14.0,
                    color: model.status == 1 ? greenColor : redColor,
                  )),
            ),
          ],
        ),
        !showDivider
            ? const SizedBox.shrink()
            : Container(
                height: 1.0,
                margin: EdgeInsets.only(
                    top: Utils.vPadding(size: 10),
                    bottom: Utils.vPadding(size: 5.0)),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: grayColor.withOpacity(0.15),
                ),
              )
      ],
    );
  }
}

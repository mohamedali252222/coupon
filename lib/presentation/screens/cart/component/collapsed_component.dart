import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../routes/routes_name.dart';
import '../../../utils/utils.dart';
import '../../../widget/primary_button.dart';
import '../cart_screen.dart';

class CollapsedComponent extends StatelessWidget {
  const CollapsedComponent(
      {super.key, required this.panelController, required this.height});

  final PanelController panelController;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Utils.symmetric(v: 0.0),
      child: Column(
        children: [
          // GestureDetector(
          //   onTap: () {
          //     panelController.isPanelOpen
          //         ? panelController.close()
          //         : panelController.open();
          //   },
          //   child: Container(
          //     height: Utils.vSize(30.0),
          //     width: Utils.vSize(30.0),
          //     margin: Utils.symmetric(v: 12.0, h: 0.0),
          //     decoration: BoxDecoration(
          //       color: Colors.red,
          //       shape: BoxShape.circle,
          //       gradient: linearGradient,
          //     ),
          //     child: const Icon(Icons.keyboard_arrow_up,
          //         color: whiteColor, size: 40.0),
          //   ),
          // ),
          const SlidingTopWidget(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const CustomText(
          //       text: "Order Amount",
          //       fontSize: 16.0,
          //       color: blackColor,
          //     ),
          //     CustomText(
          //       text: Utils.formatPrice(context, 1203),
          //       fontSize: 16.0,
          //       color: blackColor,
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 60.0,
            child: PrimaryButton(
              onPressed: () {
                if (panelController.isPanelOpen) {
                  print('onPressed is disable');
                } else {
                  Navigator.pushNamed(context, RouteNames.paymentScreen);
                  print('panel ${panelController.isPanelClosed}');
                }
              },
              text: 'Processed to Checkout',
            ),
          ),
        ],
      ),
    );
  }
}

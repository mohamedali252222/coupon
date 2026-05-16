import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text.dart';

class SingleExpansionTile extends StatelessWidget {
  const SingleExpansionTile({
    Key? key,
    this.isExpand = false,
    required this.question,
    required this.answer,
  }) : super(key: key);

  final bool isExpand;
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFE3E3E3);
    return Container(
      width: double.infinity,
      margin: Utils.symmetric(h: 16.0, v: 6.0).copyWith(bottom: 2.0),
      decoration: BoxDecoration(
          color: fillColor,
          border: Border.all(color: color),
          borderRadius: Utils.borderRadius(r: 6.0)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpand,
          childrenPadding: Utils.symmetric(h: 20.0, v: 16.0).copyWith(top: 0.0),
          iconColor: grayColor,
          collapsedIconColor: grayColor,
          title: CustomText(
            text: question,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: blackColor,
          ),
          children: [
            Container(
                margin: Utils.only(bottom: 6.0),
                color: grayColor.withOpacity(0.4),
                height: 1.0),
            //CustomText(text: answer),
            Html(
              data: answer,
              style: {
                '*': Style(color: blackColor, fontWeight: FontWeight.w500)
              },
            ),
          ],
        ),
      ),
    );
  }
}

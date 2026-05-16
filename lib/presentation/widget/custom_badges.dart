import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text.dart';

class CustomBadges extends StatelessWidget {
  const CustomBadges({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor = primaryColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      position: badges.BadgePosition.topEnd(
          top: -Utils.vSize(16.0), end: -Utils.vSize(14.0)),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: transparent,
        elevation: 0.0,
      ),
      badgeContent: Container(
        height: Utils.vSize(20.0),
        width: Utils.hSize(20.0),
        alignment: Alignment.center,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: secondaryColor),
        child: CustomText(
          text: title,
          color: whiteColor,
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: FaIcon(
        icon,
        color: iconColor,
        size: 30.0,
      ),
    );
  }
}

import 'package:algoriza_phase1_to_do_app/shared/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultCheckBox(
        {
          final VoidCallback? onTap ,
          final Color iconColor = Colors.white,
          final double bigWidthContainer = 28,
        final double bigHeightContainer = 28,
        final double radius = 0.0,
        final double smallWidthContainer = 25,
        final double smallHeightContainer = 25,
        final Color bigContainerColor = primaryColor,
        final Color smallContainerColor = primaryColor,
        final double? iconSize = 0.0}) =>
    GestureDetector(
        onTap:onTap,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: bigWidthContainer,
              height: bigHeightContainer,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: bigContainerColor),
            ),
            Container(
              width: smallWidthContainer,
              height: smallHeightContainer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color:smallContainerColor,
              ),
              child: Icon(
                Icons.check,
                color: iconColor,
                size: iconSize!,
              ),
            ),
          ],
        ));

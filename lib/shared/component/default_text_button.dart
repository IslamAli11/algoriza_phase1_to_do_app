import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double fontSize;
  final VoidCallback onPress;

  const DefaultTextButton(
      {Key? key,
        required this.text,
        required this.color,
        required this.fontSize,
        required this.textColor,
        required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: TextButton(
            onPressed: onPress,
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: fontSize),
            )));
  }
}
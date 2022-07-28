import 'dart:ui';


import 'package:flutter/material.dart';




    getColor(int? color) {
  switch (color) {
    case 0:
      return Colors.red;
    case 1:
      return Colors.yellow;
    case 2:
      return Colors.teal;
    default:
      return Colors.blue;
  }
}

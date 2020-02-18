import 'package:flutter/material.dart';

class HexColor extends Color {
  static final Color primaryColor = HexColor('#1C93C2');
  static final Color accentColor = HexColor('#3C3C3C');
  static final Color greyColor = HexColor('#B4B4B4');

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

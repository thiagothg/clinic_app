import 'package:flutter/material.dart';

class ColorsConst { //Consts para as cores
  static const primaryColor = Color(0xffffcc00); //#FFCC00
  
  static const standardText = Color(0xFF707070);
  static const Color errorColor = Color(0xFFD32F2F); 
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey600 = Color(0xFF757575);

  static const Color background = Color(0xff0e1928); //#0E1928
  static const Color red = Color(0xffff0000); // #Ff0000
  static const Color white = Color(0xffffffff); // #FFFFFF




  
  Color hexToColor(String hexCode) {
    return Color(int.parse(hexCode.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
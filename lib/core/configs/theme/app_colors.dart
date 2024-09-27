import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color.fromRGBO(244, 67, 54, 1);
  // static const primary = Color(0xFF42C83C);
  static const lightBackground = Color(0xfff2F2f2);
  static const darkBackground = Color(0xff0D0C0C);
  static const grey = Color(0xffBEBEBE);
  static const darkGrey = Color(0xff343434);
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}

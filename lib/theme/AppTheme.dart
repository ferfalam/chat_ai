import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(
      primaryColor: Color(0xFF353740),
      accentColor: Color(0xFF10A37F),
      focusColor: Color(0xFFC5C5D2),
      fontFamily: "Montserrat"
    );
  }
}
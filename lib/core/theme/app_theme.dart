import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData light() {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // add more shared styles here…
    );
  }
}

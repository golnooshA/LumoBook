import 'package:flutter/material.dart';
import '../config/design_config.dart';

abstract class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: false, // Ensure compatibility with TabBarTheme
      primaryColor: DesignConfig.primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: DesignConfig.primaryColor,
        primary: DesignConfig.primaryColor,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: DesignConfig.primaryColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DesignConfig {
  // ===================== Colors ======================

  // Light Mode
  static const Color primaryColor = Color(0xFF00BFCB);
  static const Color secondColor = Colors.orange;
  static const Color lightBlue = Color(0xFFAFECED);

  static const Color deleteCart = Color(0xFFe74645);
  static const Color rating = Colors.amber;
  static const Color priceColor = Color(0xFF00BFCB);

  static const Color textColor = Colors.black;
  static const Color subTextColor = Colors.black54;
  static const Color buttonTextColor = Colors.white;

  static const Color backgroundColor = Colors.white;
  static const Color appBarBackgroundColor = Colors.white;
  static const Color appBarTitleColor = Colors.black;
  static const Color bottomNavigation = Colors.grey;
  static const Color bottomNavigationBackground = Color(0xFFe3f6f5);
  static const Color shadowColor = Colors.black26;
  static const Color lightWhite = Colors.white70;

  // Dark Mode (for future use)
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkTextColor = Colors.white;
  static const Color darkSubTextColor = Colors.white70;

  // =================== Font & Sizes ===================

  static const String fontFamily = 'Poppins';

  static const double appBarTitleFontSize = 26;
  static const double titleSize = 28;
  static const double subTitleSize = 24;
  static const double headerSize = 18;
  static const double textSize = 16;
  static const double subTextSize = 14;
  static const double tinyTextSize = 12;

  static const FontWeight bold = FontWeight.w600;
  static const FontWeight semiBold = FontWeight.w500;
  static const FontWeight light = FontWeight.w300;

  // ====================== Shapes ======================

  static final BorderRadius border = BorderRadius.circular(10);

  static const List<BoxShadow> commonShadow = [
    BoxShadow(
      color: shadowColor,
      blurRadius: 6,
      offset: Offset(0, 3),
    ),
  ];

  // ====================== Theme =======================

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: appBarBackgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: appBarTitleColor),
      titleTextStyle: TextStyle(
        fontSize: appBarTitleFontSize,
        fontFamily: fontFamily,
        color: appBarTitleColor,
        fontWeight: DesignConfig.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: textSize,
        color: textColor,
        fontWeight: semiBold,
      ),
      bodyMedium: TextStyle(
        fontSize: subTextSize,
        color: subTextColor,
        fontWeight: light,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor,
      secondary: secondColor,
    ),
  );

}

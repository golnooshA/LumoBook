import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class ButtonText extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  final double? fontSize;
  final double? width;

  const ButtonText({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor = DesignConfig.primaryColor,
    this.textColor = Colors.white,
    this.fontSize,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3);
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Semantics(
      button: true,
      label: title,
      child: SizedBox(
        width: width ?? double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: EdgeInsets.symmetric(
              vertical: isTablet ? 20 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: DesignConfig.border,
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: (fontSize ?? DesignConfig.textSize) * scale,
              fontWeight: FontWeight.bold,
              fontFamily: DesignConfig.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}

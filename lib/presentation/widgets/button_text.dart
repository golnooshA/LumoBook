import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class ButtonText extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const ButtonText({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor = DesignConfig.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: DesignConfig.cardBorder,
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: DesignConfig.textSize,
            fontWeight: FontWeight.bold,
            fontFamily: DesignConfig.fontFamily,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/config/design_config.dart';

class SocialButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap; // ← nullable
  final Color backgroundColor;
  final String imagePath;

  const SocialButton({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
    this.backgroundColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap, // ← null-safe
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: DesignConfig.border,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: DesignConfig.fontFamily,
                fontSize: DesignConfig.textSize,
                fontWeight: DesignConfig.bold,
                color: DesignConfig.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

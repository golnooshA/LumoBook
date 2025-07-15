import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/design_config.dart';

class ButtonText extends ConsumerWidget {
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;

  const ButtonText({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor = Colors.red,

  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            fontFamily: DesignConfig.fontFamily,
            fontSize: DesignConfig.textSize,
            fontWeight: DesignConfig.fontWeightBold,
            color: DesignConfig.buttonTextColor),
        ),
      ),
    );
  }
}

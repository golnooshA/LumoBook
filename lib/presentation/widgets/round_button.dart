import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class RoundButton extends StatelessWidget {
  final String buttonText;

  const RoundButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: DesignConfig.lightBlue,
        borderRadius: DesignConfig.cardBorder,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
            fontSize: DesignConfig.textSize,
        fontFamily: DesignConfig.fontFamily,
        fontWeight: DesignConfig.fontWeightLight,
        color: DesignConfig.textColor),
      ),
    );
  }
}

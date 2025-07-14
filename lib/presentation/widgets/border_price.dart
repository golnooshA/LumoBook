import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class BorderPrice extends StatelessWidget {
  final String value;

  const BorderPrice({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: DesignConfig.priceColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '€ $value',
        style: const TextStyle(
          color: DesignConfig.priceColor,
          fontFamily: DesignConfig.fontFamily,
          fontSize: DesignConfig.tinyTextSize,
          fontWeight: DesignConfig.fontWeight,
        ),
      ),
    );
  }
}

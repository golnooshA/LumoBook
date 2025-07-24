import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class BorderPrice extends StatelessWidget {
  final String value;

  final EdgeInsets? customPadding;

  final double? customRadius;

  const BorderPrice({
    super.key,
    required this.value,
    this.customPadding,
    this.customRadius,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    final isTablet = screenWidth > 600;

    final horizontalPadding = isTablet ? 12.0 : 8.0;
    final verticalPadding = isTablet ? 6.0 : 4.0;
    final baseFontSize = isTablet ? DesignConfig.tinyTextSize * 1.2
        : DesignConfig.tinyTextSize;

    return Semantics(
      label: 'Price €$value',
      child: Container(
        padding: customPadding ??
            EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
        decoration: BoxDecoration(
          border: Border.all(color: DesignConfig.priceColor),
          borderRadius: BorderRadius.circular(customRadius ?? 20),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '€ $value',
            style: TextStyle(
              color: DesignConfig.priceColor,
              fontFamily: DesignConfig.fontFamily,
              fontSize: baseFontSize * mq.textScaleFactor.clamp(1.0, 1.2),
              fontWeight: DesignConfig.semiBold,
            ),
          ),
        ),
      ),
    );
  }
}

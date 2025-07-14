import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class PriceWithDiscount extends StatelessWidget {
  final String price;
  final String discountPrice;

  const PriceWithDiscount({
    super.key,
    required this.price,
    required this.discountPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: DesignConfig.priceColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '€ $discountPrice',
            style: const TextStyle(
              color: DesignConfig.priceColor,
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.tinyTextSize,
              fontWeight: DesignConfig.fontWeight,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(
            price,
            style: const TextStyle(
              color: DesignConfig.subTextColor,
              decoration: TextDecoration.lineThrough,
              decorationColor: DesignConfig.subTextColor,
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.tinyTextSize,
              fontWeight: DesignConfig.fontWeightLight,
            ),
          ),
        ),
      ],
    );
  }
}

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
    final scale = MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3);
    final isTablet = MediaQuery.of(context).size.width > 600;

    final double? p = double.tryParse(price);
    final double? dp = double.tryParse(discountPrice);

    final bool valid = p != null && dp != null && dp < p;

    if (!valid) {
      return Text(
        '€ $price',
        style: TextStyle(
          color: DesignConfig.priceColor,
          fontFamily: DesignConfig.fontFamily,
          fontSize: DesignConfig.tinyTextSize * scale,
          fontWeight: DesignConfig.semiBold,
        ),
      );
    }

    return Semantics(
      label: 'Discounted from €${p!.toStringAsFixed(2)} to €${dp!.toStringAsFixed(2)}',
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 12 : 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: DesignConfig.priceColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '€ ${dp.toStringAsFixed(2)}',
              style: TextStyle(
                color: DesignConfig.priceColor,
                fontFamily: DesignConfig.fontFamily,
                fontSize: DesignConfig.tinyTextSize * scale,
                fontWeight: DesignConfig.semiBold,
              ),
            ),
          ),
          const SizedBox(width: 8),

          Text(
            '€ ${p.toStringAsFixed(2)}',
            style: TextStyle(
              color: DesignConfig.subTextColor,
              decoration: TextDecoration.lineThrough,
              decorationColor: DesignConfig.subTextColor,
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.tinyTextSize * scale,
              fontWeight: DesignConfig.light,
            ),
          ),
        ],
      ),
    );
  }
}

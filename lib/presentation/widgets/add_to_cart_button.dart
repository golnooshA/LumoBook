import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class AddToCart extends StatelessWidget {
  final String title;
  final String price;
  final String discountPrice;
  final Color cardColor;
  final VoidCallback onTap;

  const AddToCart({
    super.key,
    required this.title,
    required this.price,
    required this.discountPrice,
    required this.cardColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double? originalPrice = double.tryParse(price);
    final double? discountedPrice = double.tryParse(discountPrice);

    final bool hasValidPrice = originalPrice != null && originalPrice > 0;
    final bool hasDiscount = discountedPrice != null &&
        discountedPrice > 0 &&
        discountedPrice < originalPrice!;

    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.7,
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(40),
          boxShadow: DesignConfig.commonShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: DesignConfig.fontFamily,
                  fontSize: DesignConfig.textSize,
                  fontWeight: DesignConfig.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (hasValidPrice) ...[
              const SizedBox(width: 12),
              Container(height: 24, width: 1, color: Colors.white),
              const SizedBox(width: 12),
              _buildPriceColumn(hasDiscount, discountedPrice ?? 0, originalPrice!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPriceColumn(bool hasDiscount, double dp, double op) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '€ ${hasDiscount ? dp.toStringAsFixed(2) : op.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: DesignConfig.fontFamily,
            fontSize: DesignConfig.textSize,
            fontWeight: DesignConfig.bold,
          ),
        ),
        if (hasDiscount)
          Text(
            '€ ${op.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.subTextSize,
              fontWeight: DesignConfig.semiBold,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.white,
            ),
          ),
      ],
    );
  }
}

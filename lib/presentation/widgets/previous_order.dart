import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class PreviousOrder extends StatelessWidget {
  final String title;
  final String author;
  final String price;
  final String discountPrice;
  final String cover;
  final VoidCallback onTap;

  const PreviousOrder({
    super.key,
    required this.title,
    required this.author,
    required this.price,
    required this.discountPrice,
    required this.cover,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double? parsedPrice = double.tryParse(price);
    final double? parsedDiscount = double.tryParse(discountPrice);
    final bool hasValidDiscount = parsedPrice != null &&
        parsedDiscount != null &&
        parsedDiscount > 0 &&
        parsedDiscount < parsedPrice;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: DesignConfig.shadowColor,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                cover,
                height: 270,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Title & author
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: DesignConfig.textSize,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            author,
            style: const TextStyle(
              color: DesignConfig.subTextColor,
              fontSize: DesignConfig.subTextSize,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),

          // Price block
          hasValidDiscount
              ? _priceWithDiscount(parsedPrice!, parsedDiscount!)
              : _borderPrice(price),
        ],
      ),
    );
  }

  Widget _priceWithDiscount(double original, double discounted) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: DesignConfig.priceColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '€ ${discounted.toStringAsFixed(2)}',
            style: const TextStyle(
              color: DesignConfig.priceColor,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(
            '€ ${original.toStringAsFixed(2)}',
            style: const TextStyle(
              color: DesignConfig.subTextColor,
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              decorationColor: DesignConfig.subTextColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _borderPrice(String value) {
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
          fontSize: 12,
        ),
      ),
    );
  }
}

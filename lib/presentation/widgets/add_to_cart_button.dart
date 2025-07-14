import 'package:flutter/material.dart';

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
    final dp = double.tryParse(discountPrice);
    final pp = double.tryParse(price);
    final hasValidPrices = pp != null && pp > 0;
    final hasDiscount = dp != null && dp > 0 && pp != null && dp < pp;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            if (hasValidPrices) ...[
              const SizedBox(width: 12),
              Container(height: 24, width: 1, color: Colors.white),
              const SizedBox(width: 12),
              _buildPriceBlock(hasDiscount, dp ?? 0, pp ?? 0),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBlock(bool hasDiscount, double dp, double pp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '€ ${hasDiscount ? dp.toStringAsFixed(2) : pp.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        if (hasDiscount)
          Text(
            '€ ${pp.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.white,
            ),
          ),
      ],
    );
  }
}

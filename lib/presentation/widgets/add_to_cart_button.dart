import 'package:flutter/material.dart';

class CartADButton extends StatelessWidget {
  final String title;
  final String price;
  final String discountPrice;
  final Color cardColor;
  final VoidCallback onTap;

  const CartADButton({
    super.key,
    required this.title,
    required this.price,
    required this.discountPrice,
    required this.cardColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dp = double.tryParse(discountPrice) ?? 0;
    final pp = double.tryParse(price) ?? 0;
    final hasDiscount = dp > 0 && dp < pp;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        width: 200,
        margin: EdgeInsets.symmetric(horizontal: 50),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cardColor, // Teal-like background
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(color: Colors.white, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 12),
            Container(height: 24, width: 1, color: Colors.white),
            const SizedBox(width: 12),
            hasDiscount ? _priceWithDiscount(dp, pp) : _singlePrice(pp),
          ],
        ),
      ),
    );
  }

  Widget _priceWithDiscount(double dp, double pp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '€ $dp',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Text(
          '€ $pp',
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

  Widget _singlePrice(double pp) {
    return Text(
      '€ $pp',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}

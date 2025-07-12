import 'package:flutter/material.dart';

import '../../core/config/design_config.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String cover;
  final String price;
  final String discountPrice;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.cover,
    required this.price,
    required this.onTap,
    required this.discountPrice,
  });

  @override
  Widget build(BuildContext context) {

    final hasDiscount = discountPrice.isNotEmpty;


    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card with elevation & rounded corners
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
          hasDiscount ? _priceWithDiscount() : _borderPrice(price),


        ],
      ),
    );
  }

  Widget _priceWithDiscount() {
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
              fontSize: 12,
            ),
          ),
        ),


        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          // decoration: BoxDecoration(
          //   border: Border.all(color: DesignConfig.priceColor),
          //   borderRadius: BorderRadius.circular(20),
          // ),
          child: Text(
            price,
            style: const TextStyle(
                color: DesignConfig.subTextColor,
                fontSize: 12,
                decoration: TextDecoration.lineThrough,
                decorationColor: DesignConfig.subTextColor
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


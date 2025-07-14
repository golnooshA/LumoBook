import 'package:flutter/material.dart';
import 'package:lumo_book/presentation/widgets/border_price.dart';
import 'package:lumo_book/presentation/widgets/price_with_discount.dart';

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
              borderRadius: DesignConfig.cardBorder,
              boxShadow: const [
                BoxShadow(
                  color: DesignConfig.shadowColor,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: DesignConfig.cardBorder,
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
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.textSize,
              fontWeight: DesignConfig.fontWeight,
              color: DesignConfig.textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            author,
            style: const TextStyle(
              color: DesignConfig.subTextColor,
              fontSize: DesignConfig.subTextSize,
              fontFamily: DesignConfig.fontFamily,
              fontWeight: DesignConfig.fontWeightLight,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          hasDiscount
              ? PriceWithDiscount(
            price: price,
            discountPrice: discountPrice,
          )
              : BorderPrice(value: price),
        ],
      ),
    );
  }


}

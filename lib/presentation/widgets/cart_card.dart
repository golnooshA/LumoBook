import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class CartCard extends StatelessWidget {
  final String title;
  final String author;
  final String cover;
  final double discountPrice;
  final String price;
  final VoidCallback deleteTap;
  final VoidCallback onTap;

  const CartCard({
    super.key,
    required this.title,
    required this.discountPrice,
    required this.price,
    required this.cover,
    required this.author,
    required this.deleteTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double parsedPrice = double.tryParse(price) ?? 0.0;
    final bool hasDiscount = discountPrice > 0 && discountPrice < parsedPrice;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cover,
                height: 150,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Right side: Info
          Expanded(
            child: Container(
              height: 150,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: DesignConfig.fontFamily,
                      fontSize: DesignConfig.textSize,
                      fontWeight: DesignConfig.fontWeight,
                      color: DesignConfig.textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
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
                  const Spacer(),

                  // Price display
                  if (hasDiscount) ...[
                    Text(
                      '€ $price',
                      style: const TextStyle(
                        fontFamily: DesignConfig.fontFamily,
                        fontSize: DesignConfig.tinyTextSize,
                        fontWeight: DesignConfig.fontWeight,
                        color: DesignConfig.subTextColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '€ ${discountPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: DesignConfig.priceColor,

                        fontSize: DesignConfig.subTextSize,
                        fontFamily: DesignConfig.fontFamily,
                        fontWeight: DesignConfig.fontWeight,
                      ),
                    ),
                  ] else
                    Text(
                      '€ $price',
                      style: const TextStyle(
                        color: DesignConfig.priceColor,

                        fontSize: DesignConfig.subTextSize,
                        fontFamily: DesignConfig.fontFamily,
                        fontWeight: DesignConfig.fontWeight,
                      ),
                    ),
                ],
              ),
            ),
          ),

          IconButton(
            onPressed: deleteTap,
            icon: const Icon(Icons.delete_outline, size: 28),
            color: DesignConfig.deleteCart,
          ),
        ],
      ),
    );
  }
}

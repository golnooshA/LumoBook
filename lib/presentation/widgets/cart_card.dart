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
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    final isTablet = screenWidth > 600;
    final parsedPrice = double.tryParse(price) ?? 0.0;
    final hasDiscount = discountPrice > 0 && discountPrice < parsedPrice;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: isTablet ? 110 : 100,
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    cover,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                    loadingBuilder: (ctx, child, loading) =>
                    loading == null ? child : const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: SizedBox(
              height: isTablet ? 170 : 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: DesignConfig.fontFamily,
                      fontSize: DesignConfig.textSize,
                      fontWeight: DesignConfig.semiBold,
                      color: DesignConfig.textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    author,
                    style: TextStyle(
                      color: DesignConfig.subTextColor,
                      fontSize: DesignConfig.subTextSize,
                      fontFamily: DesignConfig.fontFamily,
                      fontWeight: DesignConfig.light,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const Spacer(),

                  if (hasDiscount) ...[
                    Text(
                      '€ ${parsedPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontFamily: DesignConfig.fontFamily,
                        fontSize: DesignConfig.tinyTextSize,
                        fontWeight: DesignConfig.semiBold,
                        color: DesignConfig.subTextColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '€ ${discountPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: DesignConfig.priceColor,
                        fontSize: DesignConfig.subTextSize,
                        fontFamily: DesignConfig.fontFamily,
                        fontWeight: DesignConfig.semiBold,
                      ),
                    ),
                  ] else
                    Text(
                      '€ ${parsedPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: DesignConfig.priceColor,
                        fontSize: DesignConfig.subTextSize,
                        fontFamily: DesignConfig.fontFamily,
                        fontWeight: DesignConfig.semiBold,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Delete icon
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

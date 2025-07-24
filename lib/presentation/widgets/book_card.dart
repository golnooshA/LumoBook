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
    required this.discountPrice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool hasDiscount = discountPrice.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: screenWidth * 0.42,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCoverImage(),
            const SizedBox(height: 8),
            _buildTitle(),
            _buildAuthor(),
            const SizedBox(height: 8),
            hasDiscount
                ? PriceWithDiscount(price: price, discountPrice: discountPrice)
                : BorderPrice(value: price),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: DesignConfig.border,
        boxShadow: DesignConfig.commonShadow,
      ),
      child: ClipRRect(
        borderRadius: DesignConfig.border,
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: Image.network(
            cover,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: DesignConfig.fontFamily,
        fontSize: DesignConfig.textSize,
        fontWeight: DesignConfig.semiBold,
        color: DesignConfig.textColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildAuthor() {
    return Text(
      author,
      style: const TextStyle(
        fontFamily: DesignConfig.fontFamily,
        fontSize: DesignConfig.subTextSize,
        fontWeight: DesignConfig.light,
        color: DesignConfig.subTextColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

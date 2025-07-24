import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class BannerCard extends StatelessWidget {
  final String image;

  const BannerCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    final double cardWidth = isTablet ? screenWidth * 0.5 : screenWidth * 0.6;
    final double cardHeight = isTablet ? 200 : 140;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: DesignConfig.border,
        boxShadow: DesignConfig.commonShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
        ),
      ),
    );
  }
}

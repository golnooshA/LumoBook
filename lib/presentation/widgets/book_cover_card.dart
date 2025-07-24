import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class BookCoverCard extends StatelessWidget {
  final String bookCover;
  final VoidCallback onTap;

  const BookCoverCard({
    super.key,
    required this.bookCover,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;
    final double cardWidth = isTablet ? 140 : screenWidth * 0.32;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: DesignConfig.border,
          boxShadow: DesignConfig.commonShadow,
        ),
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: ClipRRect(
            borderRadius: DesignConfig.border,
            child: _buildImage(),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (bookCover.isEmpty) {
      return _fallbackImage();
    }

    return Image.network(
      bookCover,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) => _fallbackImage(),
    );
  }

  Widget _fallbackImage() {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
    );
  }
}

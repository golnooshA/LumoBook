import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class BookmarkCard extends StatelessWidget {
  final String cover;
  final IconData bookmark;
  final VoidCallback bookmarkTap;
  final VoidCallback onTap;

  const BookmarkCard({
    super.key,
    required this.cover,
    required this.bookmark,
    required this.bookmarkTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;
    final double cardWidth = screenWidth * 0.42;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: cardWidth,
        child: AspectRatio(
          aspectRatio: 2 / 3,
          child: Stack(
            children: [
              _buildCoverImage(),
              _buildBookmarkButton(isTablet),
            ],
          ),
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
        child: cover.isEmpty
            ? _placeholderImage()
            : Image.network(
          cover,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (_, __, ___) => _placeholderImage(),
        ),
      ),
    );
  }

  Widget _buildBookmarkButton(bool isTablet) {
    return Positioned(
      top: 8,
      right: 8,
      child: GestureDetector(
        onTap: bookmarkTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: DesignConfig.lightWhite,
            shape: BoxShape.circle,
          ),
          child: Icon(
            bookmark,
            size: isTablet ? 26 : 22,
            color: DesignConfig.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
    );
  }
}

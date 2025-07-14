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
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: DesignConfig.cardBorder,
        child: Stack(
          children: [
            // Image container
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: DesignConfig.cardBorder,
                boxShadow: const [
                  BoxShadow(
                    color: DesignConfig.shadowColor,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Image.network(
                cover,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 48),
                loadingBuilder: (ctx, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),

            // Bookmark icon
            Positioned(
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
                    color: DesignConfig.primaryColor,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

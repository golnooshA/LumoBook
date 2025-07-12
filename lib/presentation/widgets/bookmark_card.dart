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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card with elevation, image & bookmark icon
          Stack(
            children: [
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
              // Bookmark Icon Button
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: bookmarkTap,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      bookmark,
                      color: DesignConfig.priceColor,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

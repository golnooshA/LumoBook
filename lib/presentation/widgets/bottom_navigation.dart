import 'package:flutter/material.dart';
import 'package:lumo_book/core/config/design_config.dart';
import '../pages/account_page.dart';
import '../pages/bookmark_page.dart';
import '../pages/cart_page.dart';
import '../pages/home_page.dart';
import '../pages/search_page.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({super.key, required this.currentIndex});

  void _navigateTo(BuildContext context, int index) {
    if (index == currentIndex) return;

    final routes = [
      const HomePage(),
      const SearchPage(),
      const BookmarkPage(),
      const CartPage(),
      const AccountPage(),
    ];

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => routes[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    final isTablet = screenWidth > 600;
    final isLandscape = mq.orientation == Orientation.landscape;
    final textScale = mq.textScaleFactor.clamp(1.0, 1.2);

    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.search, 'label': 'Search'},
      {'icon': Icons.bookmark, 'label': 'My Library'},
      {'icon': Icons.shopping_cart, 'label': 'Cart'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      height: isLandscape ? 64 : 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        boxShadow: const [
          BoxShadow(
            color: DesignConfig.shadowColor,
            blurRadius: 6,
            offset: Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: isLandscape ? 4 : 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final isActive = index == currentIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => _navigateTo(context, index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: isLandscape ? 2 : 6,
                ),
                decoration: isActive
                    ? BoxDecoration(
                  color: DesignConfig.bottomNavigationBackground,
                  borderRadius: DesignConfig.border,
                )
                    : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      size: isTablet ? 24 : 20,
                      color: isActive
                          ? DesignConfig.primaryColor
                          : DesignConfig.bottomNavigation,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      items[index]['label'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: DesignConfig.fontFamily,
                        fontSize: isLandscape
                            ? DesignConfig.tinyTextSize * 0.9
                            : DesignConfig.tinyTextSize * textScale,
                        color: isActive
                            ? DesignConfig.primaryColor
                            : DesignConfig.bottomNavigation,
                        fontWeight: isActive
                            ? DesignConfig.bold
                            : DesignConfig.light,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

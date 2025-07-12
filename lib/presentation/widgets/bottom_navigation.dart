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
    Widget destination;
    switch (index) {
      case 0: destination = const HomePage(); break;
      case 1: destination = const SearchPage(); break;
      case 2: destination = const BookmarkPage(); break;
      case 3: destination = const CartPage(); break;
      case 4: destination = const AccountPage(); break;
      default: return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => destination));
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.search, 'label': 'Search'},
      {'icon': Icons.bookmark, 'label': 'Saved'},
      {'icon': Icons.shopping_cart, 'label': 'Cart'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isActive = index == currentIndex;
          return GestureDetector(
            onTap: () => _navigateTo(context, index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: isActive
                  ? BoxDecoration(
                color: DesignConfig.lightBlue,
                borderRadius: BorderRadius.circular(12),
              )
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(items[index]['icon'] as IconData,
                      color: isActive ? DesignConfig.bottomNavigationSelected: DesignConfig.bottomNavigation),
                  const SizedBox(height: 4),
                  Text(
                    items[index]['label'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: isActive ? DesignConfig.bottomNavigationSelected: DesignConfig.bottomNavigation,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

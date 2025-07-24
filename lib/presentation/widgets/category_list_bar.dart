import 'package:flutter/material.dart';
import 'round_button.dart';

class CategoryListBar extends StatelessWidget {
  final List<String> categories;
  final void Function(String category) onTap;

  const CategoryListBar({
    super.key,
    required this.categories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return SizedBox(
      height: isTablet ? 50 : 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final category = categories[i];
          return GestureDetector(
            onTap: () => onTap(category),
            child: RoundButton(buttonText: category),
          );
        },
      ),
    );
  }
}

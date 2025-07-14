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
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final c = categories[i];
          return GestureDetector(
            onTap: () => onTap(c),
            child: RoundButton(buttonText: c),
          );
        },
      ),
    );
  }
}

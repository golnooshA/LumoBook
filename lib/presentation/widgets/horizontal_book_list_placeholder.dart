import 'package:flutter/material.dart';

class HorizontalBookListPlaceholder extends StatelessWidget {
  const HorizontalBookListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.book, size: 48, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

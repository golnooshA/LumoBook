import 'package:flutter/material.dart';

class BookCoverCard extends StatelessWidget{
  final String bookCover;
  final VoidCallback onTap;

  const BookCoverCard({super.key, required this.bookCover, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: bookCover.isEmpty
              ? const Icon(Icons.broken_image, size: 48)
              : Image.network(
            bookCover,
            fit: BoxFit.cover,
            loadingBuilder: (ctx, child, prog) =>
            prog == null ? child : const Center(child: CircularProgressIndicator()),
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.broken_image, size: 48),
          ),
        ),
      ),
    );
  }

}
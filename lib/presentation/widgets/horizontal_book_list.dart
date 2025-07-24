import 'package:flutter/material.dart';
import '../../data/models/book.dart';
import 'book_cover_card.dart';

class HorizontalBookList extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTap;

  const HorizontalBookList({
    super.key,
    required this.books,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final listHeight = isTablet ? 240.0 : 200.0;

    if (books.isEmpty) {
      return SizedBox(
        height: listHeight,
        child: Center(
          child: Text(
            'No books found.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    return SizedBox(
      height: listHeight,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 20, right: 12),
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          final book = books[index];
          return BookCoverCard(
            bookCover: book.coverUrl,
            onTap: () => onTap(book),
          );
        },
      ),
    );
  }
}

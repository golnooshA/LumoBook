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
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (_, index) {
          final book = books[index];
          return BookCoverCard(bookCover: book.coverUrl,
            onTap: () => onTap(book)
          );
        },
      ),
    );
  }
}

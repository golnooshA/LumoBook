import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/book.dart';
import '../widgets/app_bar_builder.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/details_row.dart';

class DetailsPage extends StatelessWidget {
  final Book book;

  const DetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormat.yMMMMd().format(book.publishDate);

    return Scaffold(
      appBar: AppBarBuilder(title: 'Details'),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsRow(title: 'Author', value: book.author),
                    const SizedBox(height: 12),

                    DetailsRow(
                      title: 'Categories',
                      value: book.categories.isNotEmpty
                          ? book.categories.join(', ')
                          : '—',
                    ),
                    const SizedBox(height: 12),

                    DetailsRow(title: 'Pages', value: book.pages.toString()),
                    const SizedBox(height: 12),

                    DetailsRow(title: 'Publish Date', value: dateString),
                    const SizedBox(height: 12),

                    DetailsRow(title: 'Publisher', value: book.publisher),
                    const SizedBox(height: 12),

                    // You can add more rows here if needed in the future
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

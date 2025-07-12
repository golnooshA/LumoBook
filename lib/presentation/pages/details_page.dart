import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/config/design_config.dart';
import '../../data/models/book.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/details_row.dart';

class DetailsPage extends StatelessWidget {
  final Book book;

  const DetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormat.yMMMMd().format(book.publishDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: DesignConfig.appBarTitleFontSize,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DetailsRow(title: 'Author', value: book.author),
            const SizedBox(height: 12),

            DetailsRow(
              title: 'Categories',
              value:
                  book.categories.isNotEmpty ? book.categories.join(', ') : '—',
            ),
            const SizedBox(height: 12),

            DetailsRow(title: 'Pages', value: book.pages.toString()),
            const SizedBox(height: 12),
            DetailsRow(title: 'Publish Date', value: dateString),
            const SizedBox(height: 12),
            DetailsRow(title: 'Publisher', value: book.publisher),
            // add more rows here if you ever need them
          ],
        ),
      ),
    );
  }
}

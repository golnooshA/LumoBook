import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/book_provider.dart';
import '../widgets/app_bar_builder.dart';
import '../widgets/book_card.dart';
import '../widgets/bottom_navigation.dart';
import 'book_detail_page.dart';

class CategoryPage extends ConsumerWidget {
  final String category;

  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(categoryBooksProvider(category));

    return Scaffold(
      appBar: AppBarBuilder(title: category),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: booksAsync.when(
        loading: () =>
        const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text('Error: $e')),
        data: (books) {
          if (books.isEmpty) {
            return const Center(child: Text('No books in this category'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              // Responsive column count
              final crossAxisCount = width >= 1000
                  ? 4
                  : width >= 700
                  ? 3
                  : 2;

              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (_, i) {
                  final b = books[i];
                  return BookCard(
                    title: b.title,
                    author: b.author,
                    cover: b.coverUrl,
                    price: b.price.toStringAsFixed(2),
                    discountPrice: b.discountPrice > 0
                        ? b.discountPrice.toStringAsFixed(2)
                        : '',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailPage(book: b),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

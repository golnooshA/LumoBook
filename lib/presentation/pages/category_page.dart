import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/book_provider.dart';
import '../widgets/appBar_builder.dart';
import '../widgets/book_card.dart';
import '../widgets/bottom_navigation.dart';
import 'book_detail_page.dart';

class CategoryPage extends ConsumerWidget {
  final String category;

  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(categoryBooksProvider(category));

    return booksAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (books) {
        if (books.isEmpty) {
          return Scaffold(
            appBar: AppBarBuilder(title: category),
            bottomNavigationBar: const BottomNavigation(currentIndex: 1),
            body: const Center(child: Text('No books in this category')),
          );
        }
        return Scaffold(
          appBar: AppBarBuilder(title: category),
          bottomNavigationBar: const BottomNavigation(currentIndex: 1),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
              itemCount: books.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.48,
                crossAxisSpacing: 8,
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
                    MaterialPageRoute(builder: (_) => BookDetailPage(book: b)),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

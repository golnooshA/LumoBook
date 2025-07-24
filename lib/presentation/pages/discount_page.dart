import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/app_bar_builder.dart';
import '../widgets/book_card.dart';
import '../widgets/bottom_navigation.dart';
import 'book_detail_page.dart';

class DiscountPage extends ConsumerWidget {
  const DiscountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discountedBooks = ref.watch(discountedProvider);

    return discountedBooks.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBarBuilder(title: 'Discount'),
        body: Center(
          child: Text(
            'Error: $e',
            style: const TextStyle(
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.textSize,
              fontWeight: DesignConfig.semiBold,
              color: DesignConfig.textColor,
            ),
          ),
        ),
      ),
      data: (books) {
        final now = DateTime.now();
        final validDiscounts = books.where((b) {
          final isActive = b.discount &&
              b.discountPrice < b.price &&
              (b.discountTime == null || b.discountTime!.isAfter(now));
          return isActive;
        }).toList();

        return Scaffold(
          appBar: AppBarBuilder(title: 'Discount'),
          bottomNavigationBar: const BottomNavigation(currentIndex: 0),
          body: validDiscounts.isEmpty
              ? const Center(
            child: Text(
              'No active discounted books',
              style: TextStyle(
                fontFamily: DesignConfig.fontFamily,
                fontSize: DesignConfig.textSize,
                fontWeight: DesignConfig.semiBold,
                color: DesignConfig.textColor,
              ),
            ),
          )
              : LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final crossAxisCount = width >= 800
                  ? 4
                  : width >= 600
                  ? 3
                  : 2;

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                child: GridView.builder(
                  itemCount: validDiscounts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.48,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (_, i) {
                    final b = validDiscounts[i];
                    return BookCard(
                      title: b.title,
                      author: b.author,
                      cover: b.coverUrl,
                      price: b.price.toStringAsFixed(2),
                      discountPrice: b.discountPrice.toStringAsFixed(2),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailPage(book: b),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

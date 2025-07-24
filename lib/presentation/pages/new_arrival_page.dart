import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/app_bar_builder.dart';
import '../widgets/book_card.dart';
import '../widgets/bottom_navigation.dart';
import 'book_detail_page.dart';

class NewArrivalPage extends ConsumerWidget {
  const NewArrivalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arrivals = ref.watch(newArrivalsProvider);

    return arrivals.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBarBuilder(title: 'New Arrival'),
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
        return Scaffold(
          appBar: AppBarBuilder(title: 'New Arrival'),
          bottomNavigationBar: const BottomNavigation(currentIndex: 0),
          body: books.isEmpty
              ? const Center(
            child: Text(
              'No new arrivals',
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
              final crossAxisCount = width >= 900
                  ? 4
                  : width >= 600
                  ? 3
                  : 2;

              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: GridView.builder(
                  itemCount: books.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.48,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (_, i) {
                    final b = books[i];
                    return BookCard(
                      title: b.title,
                      author: b.author,
                      cover: b.coverUrl,
                      price: b.price.toStringAsFixed(2),
                      discountPrice: (b.discount && b.discountPrice < b.price)
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
                ),
              );
            },
          ),
        );
      },
    );
  }
}

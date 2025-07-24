import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/bookmark_card.dart';
import '../widgets/bottom_navigation.dart';
import 'book_detail_page.dart';

class BookmarkPage extends ConsumerWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmark = ref.watch(bookmarkedBooksProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: const Text(
          'My Library',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontSize: DesignConfig.appBarTitleFontSize,
            fontFamily: DesignConfig.fontFamily,
            fontWeight: DesignConfig.semiBold,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 2),
      body: bookmark.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (books) {
          if (books.isEmpty) {
            return const Center(
              child: Text(
                'No bookmarks',
                style: TextStyle(
                  fontFamily: DesignConfig.fontFamily,
                  fontSize: DesignConfig.textSize,
                  fontWeight: DesignConfig.semiBold,
                  color: DesignConfig.textColor,
                ),
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final crossAxisCount = width >= 800
                  ? 4
                  : width >= 600
                  ? 3
                  : 2;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: GridView.builder(
                  itemCount: books.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (_, i) {
                    final book = books[i];
                    return BookmarkCard(
                      cover: book.coverUrl,
                      bookmark: Icons.bookmark,
                      bookmarkTap: () => ref
                          .read(bookRepoProvider)
                          .toggleBookmark(book.id, false),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailPage(book: book),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

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
          'My Bookmarks',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontSize: DesignConfig.appBarTitleFontSize,
            fontFamily: DesignConfig.fontFamily,
            fontWeight: DesignConfig.fontWeight,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 2),
      body: bookmark.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (books) => books.isEmpty
            ? const Center(
          child: Text(
            'No bookmarks',
            style: TextStyle(
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.textSize,
              fontWeight: DesignConfig.fontWeight,
              color: DesignConfig.textColor,
            ),
          ),
        )
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GridView.builder(
            itemCount: books.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.67,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (_, i) {
              final b = books[i];
              return BookmarkCard(
                cover: b.coverUrl,
                bookmark: Icons.bookmark,
                bookmarkTap: () => ref
                    .read(bookRepoProvider)
                    .toggleBookmark(b.id, false),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookDetailPage(book: b),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

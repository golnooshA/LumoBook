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
    final bmks = ref.watch(bookmarkedBooksProvider);

    return bmks.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error:   (e,_) => Scaffold(body: Center(child: Text('Error: $e'))),
      data:    (books) {
        if (books.isEmpty) {
          return Scaffold(
            appBar: _buildAppBar(),
            bottomNavigationBar: const BottomNavigation(currentIndex: 2),
            body: const Center(child: Text('No bookmarks')) ,
          );
        }
        return Scaffold(
          appBar: _buildAppBar(),
          bottomNavigationBar: const BottomNavigation(currentIndex: 2),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: GridView.builder(
              itemCount: books.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.67,
                crossAxisSpacing: 8, mainAxisSpacing: 20,
              ),
              itemBuilder: (_, i) {
                final b = books[i];
                return BookmarkCard(
                  cover: b.coverUrl,
                  bookmark: Icons.bookmark,
                  bookmarkTap: () =>
                      ref.read(bookRepoProvider).toggleBookmark(b.id, false),
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
        );
      },
    );
  }

  AppBar _buildAppBar() => AppBar(
    backgroundColor: DesignConfig.appBarBackgroundColor,
    centerTitle: true,
    title: const Text('Bookmark'),
  );
}

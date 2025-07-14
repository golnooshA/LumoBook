import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/bookmark_card.dart';
import '../widgets/bottom_navigation.dart';
import 'book_detail_page.dart';
import '../widgets/book_cover_card.dart';

class BookmarkPage extends ConsumerStatefulWidget {
  const BookmarkPage({super.key});

  @override
  ConsumerState<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends ConsumerState<BookmarkPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookmark = ref.watch(bookmarkedBooksProvider);
    final purchased = ref.watch(purchasedBooksProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: const Text('My Library',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: DesignConfig.appBarTitleFontSize,
          )),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: DesignConfig.primaryColor,
          labelColor: DesignConfig.primaryColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: DesignConfig.textSize,
          ),
          tabs: const [
            Tab(text: 'Bookmarks'),
            Tab(text: 'Purchased'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 2),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Bookmarked Tab
          bookmark.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (books) => books.isEmpty
                ? const Center(child: Text('No bookmarks'))
                : Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: GridView.builder(
                      itemCount: books.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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

          // Purchased Tab
          purchased.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (books) => books.isEmpty
                ? const Center(child: Text('No purchased books'))
                : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: GridView.builder(
                      itemCount: books.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.67,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 20,
                          ),
                      itemBuilder: (_, i) {
                        final b = books[i];
                        return BookCoverCard(
                          bookCover: b.coverUrl,
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
        ],
      ),
    );
  }
}

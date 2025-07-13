import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/bookmark_card.dart';
import '../widgets/bottom_navigation.dart';
import 'book_detail_page.dart';

// class BookmarkPage extends ConsumerWidget {
//   const BookmarkPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final bmks = ref.watch(bookmarkedBooksProvider);
//
//     return bmks.when(
//       loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
//       error:   (e,_) => Scaffold(body: Center(child: Text('Error: $e'))),
//       data:    (books) {
//         if (books.isEmpty) {
//           return Scaffold(
//             appBar: _buildAppBar(),
//             bottomNavigationBar: const BottomNavigation(currentIndex: 2),
//             body: const Center(child: Text('No bookmarks')) ,
//           );
//         }
//         return Scaffold(
//           appBar: _buildAppBar(),
//           bottomNavigationBar: const BottomNavigation(currentIndex: 2),
//           body: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
//             child: GridView.builder(
//               itemCount: books.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, childAspectRatio: 0.67,
//                 crossAxisSpacing: 8, mainAxisSpacing: 20,
//               ),
//               itemBuilder: (_, i) {
//                 final b = books[i];
//                 return BookmarkCard(
//                   cover: b.coverUrl,
//                   bookmark: Icons.bookmark,
//                   bookmarkTap: () =>
//                       ref.read(bookRepoProvider).toggleBookmark(b.id, false),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => BookDetailPage(book: b),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   AppBar _buildAppBar() => AppBar(
//     backgroundColor: DesignConfig.appBarBackgroundColor,
//     centerTitle: true,
//     title: const Text('Bookmark'),
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/bookmark_card.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/book_cover_card.dart';
import 'book_detail_page.dart';

class BookmarkPage extends ConsumerStatefulWidget {
  const BookmarkPage({super.key});

  @override
  ConsumerState<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends ConsumerState<BookmarkPage> with SingleTickerProviderStateMixin {
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
    final bmks = ref.watch(bookmarkedBooksProvider);
    final purchased = ref.watch(purchasedBooksProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: const Text('My Library'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: DesignConfig.addCart,
          labelColor: DesignConfig.addCart,
          unselectedLabelColor: Colors.grey,
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
          bmks.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (books) => books.isEmpty
                ? const Center(child: Text('No bookmarks'))
                : Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: books.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.67,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 20,
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
          ),

          // Purchased Tab
          purchased.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (books) => books.isEmpty
                ? const Center(child: Text('No purchased books'))
                : Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: books.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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


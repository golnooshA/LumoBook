import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumo_book/presentation/widgets/appBar_builder.dart';
import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../providers/category_provider.dart';
import '../widgets/book_cover_card.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/category_list_bar.dart';
import '../widgets/round_button.dart';
import 'book_detail_page.dart';
import 'category_page.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _ctrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final allBooksAsync  = ref.watch(allBooksProvider);

    return Scaffold(
      backgroundColor: DesignConfig.backgroundColor,


      appBar: AppBarBuilder(title: 'Search', automaticallyImplyLeading: false),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _ctrl,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search books …',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (v) => setState(() => _query = v.trim()),
            ),
          ),

          // ─ Categories ─
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Categories',
                style: TextStyle(
                  fontSize: DesignConfig.textSize,
                  fontWeight: DesignConfig.fontWeightBold,
                  fontFamily: DesignConfig.fontFamily,
                  color: DesignConfig.textColor
                )),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: categoriesAsync.when(
              loading: () => const SizedBox(height: 40),
              error: (_, __) => const SizedBox(height: 40),
              data: (cats) => CategoryListBar(
                categories: cats.map((e) => e.name).toList(),
                onTap: (selectedCategory) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryPage(category: selectedCategory),
                    ),
                  );
                },
              ),
            ),
          ),

          // ─ Results ─
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Results',
                style: TextStyle(
                    fontSize: DesignConfig.textSize,
                    fontWeight: DesignConfig.fontWeightBold,
                    fontFamily: DesignConfig.fontFamily,
                    color: DesignConfig.textColor
                )),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: allBooksAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (books) {
                final filtered = books
                    .where((b) => b.matchesQuery(_query))
                    .toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('No books found'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filtered.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .65,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (_, i) {
                    final b = filtered[i];
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

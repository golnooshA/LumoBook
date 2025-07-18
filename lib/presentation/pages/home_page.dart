import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/banner_card.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/horizontal_book_list.dart';
import '../widgets/section_header.dart';
import 'book_detail_page.dart';
import 'discount_page.dart';
import 'new_arrival_page.dart';
import 'search_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newArrivals = ref.watch(newArrivalsProvider);
    final discounted = ref.watch(discountedProvider);
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!
        : user?.email?.split('@').first ?? 'User';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        elevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello,',
                  style: TextStyle(
                    fontFamily: DesignConfig.fontFamily,
                    fontSize: DesignConfig.subTextSize,
                    fontWeight: DesignConfig.fontWeightLight,
                    color: DesignConfig.subTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                FutureBuilder<User?>(
                  future: Future.value(FirebaseAuth.instance.currentUser),
                  builder: (context, snapshot) {

                    return Text(
                      userName,
                      style: const TextStyle(
                        fontFamily: DesignConfig.fontFamily,
                        fontSize: DesignConfig.subTitleSize,
                        fontWeight: DesignConfig.fontWeight,
                        color: DesignConfig.textColor,
                      ),
                    );
                  },
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchPage()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          // Banner
          Container(
            height: 200,
            color: DesignConfig.orange,
            alignment: Alignment.center,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                BannerCard(image: 'assets/image/banner_one.png'),
                BannerCard(image: 'assets/image/banner_two.png'),
              ],
            ),
          ),

          // New Arrival
          SectionHeader(
            title: 'New Arrival',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NewArrivalPage()),
            ),
          ),
          newArrivals.when(
            loading: () => const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Error: $e',
                style: TextStyle(
                  fontFamily: DesignConfig.fontFamily,
                  fontSize: DesignConfig.textSize,
                  fontWeight: DesignConfig.fontWeight,
                  color: DesignConfig.textColor,
                ),
              ),
            ),
            data: (books) => HorizontalBookList(
              books: books.take(4).toList(),
              onTap: (b) => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookDetailPage(book: b)),
              ),
            ),
          ),

          // Discount
          SectionHeader(
            title: 'Discount',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DiscountPage()),
            ),
          ),
          discounted.when(
            loading: () => const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Error: $e',
                style: TextStyle(
                  fontFamily: DesignConfig.fontFamily,
                  fontSize: DesignConfig.textSize,
                  fontWeight: DesignConfig.fontWeight,
                  color: DesignConfig.textColor,
                ),
              ),
            ),
            data: (books) => HorizontalBookList(
              books: books.take(4).toList(),
              onTap: (b) => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookDetailPage(book: b)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/banner_card.dart';
import '../widgets/horizontal_book_list.dart';
import '../widgets/section_header.dart';
import '../widgets/bottom_navigation.dart';
import 'book_detail_page.dart';
import 'discount_page.dart';
import 'new_arrival_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newArrivals = ref.watch(newArrivalsProvider);
    final discounted = ref.watch(discountedProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        title: Text(
          'Lumo',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
      body: ListView(
        children: [
          Container(
            height: 200,
            color: DesignConfig.light_light_blue,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                BannerCard(image: 'assets/image/banner_one.png'),
                BannerCard(image: 'assets/image/banner_two.png'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          SectionHeader(
            title: 'New Arrival',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NewArrivalPage()),
            ),
          ),
          newArrivals.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Error: $e'),
            data: (books) => HorizontalBookList(
              books: books.take(4).toList(),
              onTap: (b) => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookDetailPage(book: b)),
              ),
            ),
          ),

          SectionHeader(
            title: 'Discount',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DiscountPage()),
            ),
          ),
          discounted.when(
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => Text('Error: $e'),
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

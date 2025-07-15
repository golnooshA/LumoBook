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
              children: const [
                Text(
                  'Hello,',
                  style: TextStyle(
                      fontFamily: DesignConfig.fontFamily,
                      fontSize: DesignConfig.subTextSize,
                      fontWeight: DesignConfig.fontWeightLight,
                      color: DesignConfig.subTextColor),
                ),
                SizedBox(height: 4),
                Text(
                  'Jack Fisher',
                  style: TextStyle(
                      fontFamily: DesignConfig.fontFamily,
                      fontSize: DesignConfig.subTitleSize,
                      fontWeight: DesignConfig.fontWeight,
                      color: DesignConfig.textColor
                  ),
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
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
      body: ListView(
        children: [
          SizedBox(height: 12),
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
          // const SizedBox(height: 12),

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
            error: (e, _) => Text('Error: $e',style: TextStyle(
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.textSize,
              fontWeight: DesignConfig.fontWeight,
              color: DesignConfig.textColor,
            )),
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
            loading: () => const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),

            error: (e, _) => Text('Error: $e',style: TextStyle(
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.textSize,
              fontWeight: DesignConfig.fontWeight,
              color: DesignConfig.textColor,
            ),),
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

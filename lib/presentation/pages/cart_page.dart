import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumo_book/presentation/widgets/book_card.dart';
import '../../core/config/design_config.dart';
import '../providers/book_provider.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/cart_card.dart';
import 'book_detail_page.dart';
import 'payment_done_page.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage>
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
    final cartAsync = ref.watch(cartBooksProvider);
    final purchasedAsync = ref.watch(purchasedBooksProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: const Text('Cart'),
        automaticallyImplyLeading: false,

        bottom: TabBar(
          controller: _tabController,
          indicatorColor: DesignConfig.primaryColor,
          labelColor: DesignConfig.primaryColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontFamily: 'Poppins',
            fontWeight: DesignConfig.fontWeightLight,
            fontSize: DesignConfig.textSize,
          ),
          tabs: [
            cartAsync.when(
              data: (list) => Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Cart'),
                    const SizedBox(width: 6),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${list.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: DesignConfig.tinyTextSize,
                          fontWeight: DesignConfig.fontWeight
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => const Tab(text: 'Cart'),
              error: (_, __) => const Tab(text: 'Cart'),
            ),
            const Tab(text: 'Previous'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 3),
      body: TabBarView(
        controller: _tabController,
        children: [
          // In-Cart Items
          cartAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (books) {
              if (books.isEmpty) {
                return const Center(child: Text('No items in cart'));
              }
              final total = books.fold<double>(0, (sum, b) => sum + b.price);
              final discount = books.fold<double>(
                0,
                (sum, b) =>
                    sum +
                    (b.discountPrice > 0 ? (b.price - b.discountPrice) : 0),
              );
              final payable = total - discount;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: books.length,
                      itemBuilder: (_, i) {
                        final b = books[i];
                        return CartCard(
                          title: b.title,
                          author: b.author,
                          price: b.price.toStringAsFixed(2),
                          discountPrice: b.discountPrice,
                          cover: b.coverUrl,
                          deleteTap: () => ref
                              .read(bookRepoProvider)
                              .toggleCart(b.id, false),
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  _buildSummary(total, discount, payable),
                ],
              );
            },
          ),

          // Previous Orders Grid
          purchasedAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (books) {
              if (books.isEmpty) {
                return const Center(child: Text('No previous orders'));
              }
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),

                child: GridView.builder(
                  itemCount: books.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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
                        MaterialPageRoute(builder: (_) => BookDetailPage(book: b)),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(double total, double discount, double payable) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(color: Colors.grey)),
              Text('${total.toStringAsFixed(2)} €'),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Discount', style: TextStyle(color: Colors.red)),
              Text('-${discount.toStringAsFixed(2)} €'),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payable',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${payable.toStringAsFixed(2)} €',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await ref.read(bookRepoProvider).purchaseAllCart();
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => PaymentDonePage()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: DesignConfig.cardBorder,
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

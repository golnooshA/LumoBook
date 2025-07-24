import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumo_book/presentation/widgets/book_card.dart';
import 'package:lumo_book/presentation/widgets/button_text.dart';
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
        title: const Text(
          'Cart',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontSize: DesignConfig.appBarTitleFontSize,
            fontFamily: DesignConfig.fontFamily,
            fontWeight: DesignConfig.semiBold,
          ),
        ),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: DesignConfig.primaryColor,
          labelColor: DesignConfig.primaryColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(
            fontSize: DesignConfig.textSize,
            fontFamily: DesignConfig.fontFamily,
            fontWeight: DesignConfig.semiBold,
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
                          fontWeight: DesignConfig.semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => const Tab(text: 'Cart'),
              error: (_, __) => const Tab(text: 'Cart'),
            ),
            const Tab(text: 'Purchased'),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 3),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCartTab(cartAsync),
          _buildPurchasedTab(purchasedAsync),
        ],
      ),
    );
  }

  Widget _buildCartTab(AsyncValue<List<dynamic>> cartAsync) {
    return cartAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _buildErrorText('Error: $e'),
      data: (books) {
        if (books.isEmpty) {
          return _buildCenteredText('No items in cart');
        }

        final total = books.fold<double>(0, (sum, b) => sum + b.price);
        final discount = books.fold<double>(
          0,
              (sum, b) => sum + (b.discountPrice > 0 ? (b.price - b.discountPrice) : 0),
        );
        final payable = total - discount;

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: books.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, i) {
                  final b = books[i];
                  return CartCard(
                    title: b.title,
                    author: b.author,
                    price: b.price.toStringAsFixed(2),
                    discountPrice: b.discountPrice,
                    cover: b.coverUrl,
                    deleteTap: () => ref.read(bookRepoProvider).toggleCart(b.id, false),
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
            const Divider(height: 1),
            _buildSummary(total, discount, payable),
          ],
        );
      },
    );
  }

  Widget _buildPurchasedTab(AsyncValue<List<dynamic>> purchasedAsync) {
    return purchasedAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _buildErrorText('Error: $e'),
      data: (books) {
        if (books.isEmpty) {
          return _buildCenteredText('No previous orders');
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: GridView.builder(
                itemCount: books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
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
                      MaterialPageRoute(
                        builder: (_) => BookDetailPage(book: b),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSummary(double total, double discount, double payable) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSummaryRow('Total', '${total.toStringAsFixed(2)} €', DesignConfig.subTextColor),
          const SizedBox(height: 6),
          _buildSummaryRow('Discount', '-${discount.toStringAsFixed(2)} €', DesignConfig.deleteCart),
          const SizedBox(height: 6),
          _buildSummaryRow('Payable', '${payable.toStringAsFixed(2)} €', DesignConfig.textColor, bold: true),
          const SizedBox(height: 16),
          ButtonText(
            title: 'Checkout',
            onTap: () async {
              await ref.read(bookRepoProvider).purchaseAllCart();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentDonePage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color color, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: DesignConfig.fontFamily,
            fontSize: DesignConfig.subTextSize,
            fontWeight: bold ? DesignConfig.bold : DesignConfig.semiBold,
            color: color,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: DesignConfig.fontFamily,
            fontSize: DesignConfig.subTextSize,
            fontWeight: bold ? DesignConfig.bold : DesignConfig.semiBold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCenteredText(String text) => Center(
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: DesignConfig.fontFamily,
        fontSize: DesignConfig.textSize,
        fontWeight: DesignConfig.semiBold,
        color: DesignConfig.textColor,
      ),
    ),
  );

  Widget _buildErrorText(String error) => Center(
    child: Text(
      error,
      style: const TextStyle(
        fontFamily: DesignConfig.fontFamily,
        fontSize: DesignConfig.textSize,
        fontWeight: DesignConfig.semiBold,
        color: DesignConfig.textColor,
      ),
    ),
  );
}

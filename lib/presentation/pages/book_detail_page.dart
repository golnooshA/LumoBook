import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/config/design_config.dart';
import '../../data/models/book.dart';
import '../providers/book_provider.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/appBar_builder.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/details_row.dart';
import 'description_page.dart';
import 'details_page.dart';
import 'pdf_viewer_page.dart';

class BookDetailPage extends ConsumerStatefulWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  ConsumerState<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends ConsumerState<BookDetailPage> {
  late bool isBookmarked;
  late bool isInCart;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.book.bookmark;
    isInCart = widget.book.cart;
  }

  Future<void> _toggleBookmark() async {
    final newStatus = !isBookmarked;
    setState(() => isBookmarked = newStatus);
    await FirebaseFirestore.instance
        .collection('books')
        .doc(widget.book.id)
        .update({'bookmark': newStatus});
  }

  Future<void> _toggleCart() async {
    final newStatus = !isInCart;
    setState(() => isInCart = newStatus);
    await FirebaseFirestore.instance
        .collection('books')
        .doc(widget.book.id)
        .update({'cart': newStatus});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(newStatus ? 'Added to cart' : 'Removed from cart',
        ),
      ),
    );
  }

  void _openPdfInWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PDFWebViewPage(url: url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final purchasedAsync = ref.watch(purchasedBooksProvider);

    return Scaffold(
      appBar: AppBarBuilder(title: ''),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            _buildCover(book.coverUrl),
            const SizedBox(height: 20),
            _buildTitle(book),
            const SizedBox(height: 8),
            _buildRatingRow(book),
            const SizedBox(height: 20),
            _buildPurchaseButton(book, purchasedAsync),
            const SizedBox(height: 24),
            _buildSectionTitle('Description', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      DescriptionPage(description: book.description),
                ),
              );
            }),
            const Divider(height: 20),
            Text(
              book.description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Details', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailsPage(book: book)),
              );
            }),
            const Divider(height: 20),
            DetailsRow(title: 'Author', value: book.author),
            DetailsRow(title: 'Categories', value: book.categories.join(', ')),
            DetailsRow(title: 'Pages', value: book.pages.toString()),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCover(String url) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(url, height: 220),
        ),
      ),
    );
  }

  Widget _buildTitle(Book book) {
    return Text(
      book.title,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: DesignConfig.headerSize,
        fontWeight: DesignConfig.fontWeight,
        color: DesignConfig.textColor,
        fontFamily: DesignConfig.fontFamily,
      ),
    );
  }

  Widget _buildRatingRow(Book book) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          5,
          (i) => Icon(
            i < book.rating.round() ? Icons.star : Icons.star_border,
            color: DesignConfig.rating,
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          book.rating.toString(),
          style: const TextStyle(
            color: DesignConfig.subTextColor,
            fontSize: DesignConfig.tinyTextSize,
            fontFamily: DesignConfig.fontFamily,
            fontWeight: DesignConfig.fontWeightLight,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: DesignConfig.primaryColor,
            size: 30,
          ),
          onPressed: _toggleBookmark,
        ),
        IconButton(
          icon: const Icon(
            Icons.share,
            size: 30,
            color: DesignConfig.primaryColor,
          ),
          onPressed: () {
            final text =
                '${book.title} by ${book.author}\nCheck it out on Lumo!';
            Share.share(text);
          },
        ),
      ],
    );
  }

  Widget _buildPurchaseButton(
    Book book,
    AsyncValue<List<Book>> purchasedAsync,
  ) {
    return purchasedAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => const Text('Error loading purchase status'),
      data: (purchasedBooks) {
        final isPurchased = purchasedBooks.any((b) => b.id == book.id);
        if (isPurchased) {
          return AddToCart(
            title: 'Read Book',
            price: '',
            discountPrice: '',
            cardColor: DesignConfig.orange,
            onTap: () => _openPdfInWebView(book.fileUrl),
          );
        } else {
          return AddToCart(
            title: isInCart ? 'Delete from Cart' : 'Add to cart',
            price: book.price.toString(),
            discountPrice: book.discountPrice.toString(),
            cardColor: isInCart
                ? DesignConfig.deleteCart
                : DesignConfig.primaryColor,
            onTap: _toggleCart,
          );
        }
      },
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: DesignConfig.textColor,
            fontSize: DesignConfig.subTextSize,
            fontFamily: DesignConfig.fontFamily,
            fontWeight: DesignConfig.fontWeightBold,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: const Text(
            'more >',
            style: TextStyle(
              color: DesignConfig.orange,
              fontFamily: DesignConfig.fontFamily,
              fontSize: DesignConfig.subTextSize,
              fontWeight: DesignConfig.fontWeightLight,
            ),
          ),
        ),
      ],
    );
  }
}

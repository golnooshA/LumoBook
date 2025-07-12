import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/config/design_config.dart';
import '../../data/models/book.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/details_row.dart';
import 'description_page.dart';
import 'details_page.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;
  const BookDetailPage({super.key, required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late bool isBookmarked;
  late bool isInCart;

  // ❗️فرض: لیست کتاب‌های خریداری شده (بعداً از Firestore لود کن)
  final Set<String> purchasedBookIds = {
    // 'bookId1', 'bookId2', ...
  };

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.book.bookmark;
    isInCart = widget.book.cart;
  }

  void _toggleBookmark() async {
    final newStatus = !isBookmarked;
    setState(() => isBookmarked = newStatus);
    await FirebaseFirestore.instance
        .collection('books')
        .doc(widget.book.id)
        .update({'bookmark': newStatus});
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final isPurchased = purchasedBookIds.contains(book.id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: DesignConfig.appBarBackgroundColor,
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Center(
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
                  child: Image.network(book.coverUrl, height: 220),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              book.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  5,
                      (i) => Icon(
                    i < book.rating.round() ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(book.rating.toString(), style: const TextStyle(color: Colors.grey)),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  ),
                  onPressed: _toggleBookmark,
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    final text = '${book.title} by ${book.author}\nCheck it out on Lumo!';
                    Share.share(text);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ✅ دکمه خرید یا دانلود
            isPurchased
                ? ElevatedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text('Download File'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () async {
                final url = book.fileUrl;
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to open file')),
                  );
                }
              },
            )
                : CartADButton(
              title: isInCart ? 'Delete from Cart' : 'Add to cart',
              price: book.price.toString(),
              discountPrice: book.discountPrice.toString(),
              cardColor: isInCart ? DesignConfig.deleteCart : DesignConfig.addCart,
              onTap: () async {
                final newStatus = !isInCart;
                setState(() => isInCart = newStatus);
                await FirebaseFirestore.instance
                    .collection('books')
                    .doc(book.id)
                    .update({'cart': newStatus});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(newStatus ? 'Added to cart' : 'Removed from cart')),
                );
              },
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DescriptionPage(description: book.description),
                    ),
                  ),
                  child: const Text('more >', style: TextStyle(color: Colors.orange)),
                ),
              ],
            ),
            const Divider(height: 20),
            Text(book.description, maxLines: 5, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Details', style: TextStyle(fontWeight: FontWeight.bold)),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailsPage(book: book)),
                  ),
                  child: const Text('more >', style: TextStyle(color: Colors.orange)),
                ),
              ],
            ),
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
}


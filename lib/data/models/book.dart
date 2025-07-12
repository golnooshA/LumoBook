import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String description;
  final int pages;
  final DateTime publishDate;
  final String publisher;
  final double rating;
  final String fileUrl;
  final bool discount;
  final bool cart;
  final bool bookmark;
  final double price;
  final double discountPrice;
  final List<String> categories;
  final DateTime? discountTime;
  final bool purchased;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.description,
    required this.pages,
    required this.publishDate,
    required this.publisher,
    required this.rating,
    required this.fileUrl,
    required this.discount,
    required this.cart,
    required this.bookmark,
    required this.price,
    required this.discountPrice,
    required this.categories,
    this.discountTime,
    required this.purchased,
  });

  factory Book.fromFirestore(Map<String, dynamic> json, String id) {
    final rawCats = json['categories'] ?? json['category'];
    final List<String> cats;
    if (rawCats is List) {
      cats = rawCats
          .map((e) => e.toString().trim())
          .where((s) => s.isNotEmpty)
          .toList(growable: false);
    } else if (rawCats != null) {
      cats = [rawCats.toString().trim()];
    } else {
      cats = const [];
    }

    return Book(
      id: id,
      title: json['title']?.toString() ?? '',
      author: json['author']?.toString() ?? '',
      coverUrl:
          json['cover_url']?.toString() ?? json['coverUrl']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      pages: (json['pages'] is int)
          ? json['pages'] as int
          : int.tryParse(json['pages']?.toString() ?? '') ?? 0,
      publishDate:
          (json['publish_date'] as Timestamp?)?.toDate() ??
          (json['publishDate'] as Timestamp?)?.toDate() ??
          DateTime(1900),
      publisher: json['publisher']?.toString() ?? '',
      rating: (json['rating'] is num)
          ? (json['rating'] as num).toDouble()
          : double.tryParse(json['rating']?.toString() ?? '') ?? 0.0,
      fileUrl:
          json['file_url']?.toString() ?? json['fileUrl']?.toString() ?? '',
      discount: json['discount'] as bool? ?? false,
      cart: json['cart'] as bool? ?? false,
      bookmark: json['bookmark'] as bool? ?? false,
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      discountPrice: (json['discount_price'] is num)
          ? (json['discount_price'] as num).toDouble()
          : double.tryParse(json['discount_price']?.toString() ?? '') ?? 0.0,
      categories: cats,
      discountTime: (json['discount_time'] as Timestamp?)?.toDate(),
      purchased: json['purchased'] is bool
          ? json['purchased']
          : json['purchased']?.toString().toLowerCase() == 'true',

    );
  }

  bool matchesQuery(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    if (title.toLowerCase().contains(q)) return true;
    return categories.any((c) => c.toLowerCase().contains(q));
  }
}

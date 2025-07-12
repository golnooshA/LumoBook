import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/book.dart';
import '../../data/repositories/book_repository.dart';

final bookRepoProvider = Provider<BookRepository>((ref) => BookRepository());

final allBooksProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchAll());

final newArrivalsProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchNewArrivals());

final discountedProvider = FutureProvider<List<Book>>((ref) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('books')
      .where('discount', isEqualTo: true)
      .get();

  final now = DateTime.now();

  return snapshot.docs
      .map((doc) => Book.fromFirestore(doc.data(), doc.id))
      .where((book) =>
  book.discountTime == null || book.discountTime!.isAfter(now))
      .toList();
});


final categoryBooksProvider = StreamProvider.family<List<Book>, String>((ref, category) =>
    ref.watch(bookRepoProvider).watchByCategory(category));

final bookmarkedBooksProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchBookmarked());

final cartBooksProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchInCart());

final purchasedBooksProvider = StreamProvider<List<Book>>((ref) =>
    ref.watch(bookRepoProvider).watchPurchased());

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class BookRepository {
  final _col = FirebaseFirestore.instance.collection('books');

  Stream<List<Book>> watchAll() =>
      _col.orderBy('title').snapshots().map((snap) =>
          snap.docs.map((d) => Book.fromFirestore(d.data(), d.id)).toList()
      );

  Stream<List<Book>> watchNewArrivals() => watchAll().map((books) =>
      books.where((b) => !b.discount && b.discountPrice == 0).toList()
  );

  Stream<List<Book>> watchDiscounted() =>
      _col.where('discountPrice', isGreaterThan: 0).snapshots().map((snap) =>
          snap.docs.map((d) => Book.fromFirestore(d.data(), d.id)).toList()
      );

  Stream<List<Book>> watchByCategory(String category) =>
      watchAll().map((books) =>
          books.where((b) => b.categories.contains(category)).toList()
      );

  Stream<List<Book>> watchBookmarked() =>
      _col.where('bookmark', isEqualTo: true).snapshots().map((snap) =>
          snap.docs.map((d) => Book.fromFirestore(d.data(), d.id)).toList()
      );

  Stream<List<Book>> watchInCart() =>
      _col.where('cart', isEqualTo: true).snapshots().map((snap) =>
          snap.docs.map((d) => Book.fromFirestore(d.data(), d.id)).toList()
      );

  Stream<List<Book>> watchPurchased() =>
      _col.where('purchased', isEqualTo: true).snapshots().map((snap) =>
          snap.docs.map((d) => Book.fromFirestore(d.data(), d.id)).toList()
      );

  /// Toggle the bookmark flag
  Future<void> toggleBookmark(String id, bool value) {
    return _col.doc(id).update({'bookmark': value});
  }

  /// Toggle the cart flag
  Future<void> toggleCart(String id, bool value) {
    return _col.doc(id).update({'cart': value});
  }

  /// Checkout: move all cart items to purchased
  Future<void> purchaseAllCart() async {
    final batch = FirebaseFirestore.instance.batch();
    final cartSnap = await _col.where('cart', isEqualTo: true).get();
    for (final doc in cartSnap.docs) {
      batch.update(doc.reference, {'cart': false, 'purchased': true});
    }
    return batch.commit();
  }
}

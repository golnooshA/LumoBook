import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class BookRepository {
  final CollectionReference _col = FirebaseFirestore.instance.collection('books');

  /// Map Firestore snapshot to list of Book objects
  List<Book> _fromSnap(QuerySnapshot snap) =>
      snap.docs.map((doc) => Book.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList();

  /// Watch all books, ordered by title
  Stream<List<Book>> watchAll() {
    return _col.orderBy('title').snapshots().map(_fromSnap);
  }

  /// Watch books that are new arrivals (not discounted)
  Stream<List<Book>> watchNewArrivals() {
    return watchAll().map((books) =>
        books.where((b) => !b.discount && b.discountPrice == 0).toList());
  }

  /// Watch books with discount price > 0
  Stream<List<Book>> watchDiscounted() {
    return _col
        .where('discountPrice', isGreaterThan: 0)
        .snapshots()
        .map(_fromSnap);
  }

  /// Watch books in a specific category
  Stream<List<Book>> watchByCategory(String category) {
    return watchAll().map((books) =>
        books.where((b) => b.categories.contains(category)).toList());
  }

  /// Watch bookmarked books
  Stream<List<Book>> watchBookmarked() {
    return _col
        .where('bookmark', isEqualTo: true)
        .snapshots()
        .map(_fromSnap);
  }

  /// Watch books currently in the cart
  Stream<List<Book>> watchInCart() {
    return _col
        .where('cart', isEqualTo: true)
        .snapshots()
        .map(_fromSnap);
  }

  /// Watch books that have been purchased
  Stream<List<Book>> watchPurchased() {
    return _col
        .where('purchased', isEqualTo: true)
        .snapshots()
        .map(_fromSnap);
  }

  /// Toggle bookmark status for a book
  Future<void> toggleBookmark(String bookId, bool value) {
    return _col.doc(bookId).update({'bookmark': value});
  }

  /// Toggle cart status for a book
  Future<void> toggleCart(String bookId, bool value) {
    return _col.doc(bookId).update({'cart': value});
  }

  /// Checkout all cart items: mark them as purchased
  Future<void> purchaseAllCart() async {
    final cartBooks = await _col.where('cart', isEqualTo: true).get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in cartBooks.docs) {
      batch.update(doc.reference, {
        'cart': false,
        'purchased': true,
      });
    }

    await batch.commit();
  }
}

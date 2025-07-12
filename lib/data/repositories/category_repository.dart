import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';

class CategoryRepository {
  final _col = FirebaseFirestore.instance.collection('categories');

  Stream<List<Category>> watchAll() =>
      _col
          .orderBy('name')
          .snapshots()
          .map((snap) => snap.docs
          .map((d) => Category.fromFirestore(d.data(), d.id))
          .toList());
}

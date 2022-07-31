import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:towermarket/models/category.dart';

class CategoryFirebase {
  final categories = FirebaseFirestore.instance.collection('categories');

  Stream<Iterable<Category>> allCategories() {
    final allCategories = categories
        .snapshots()
        .map((event) => event.docs.map((doc) => Category.fromSnapshot(doc)));
    return allCategories;
  }
}

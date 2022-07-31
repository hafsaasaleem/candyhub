import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:towermarket/models/product.dart';

class ProductFirebase {
  final categories = FirebaseFirestore.instance.collection('categories');

  Stream<Iterable<Product>> allCategories({String documentId = ''}) {
    final allproducts = categories
        .doc(documentId)
        .collection('products')
        .where('inStock', isEqualTo: true)
        .snapshots()
        .map((event) => event.docs.map((doc) => Product.fromSnapshot(doc)));
    return allproducts;
  }
}

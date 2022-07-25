import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/models/product.dart';

import 'product_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.categoryKey,
  }) : super(key: key);

  final String categoryKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Product>>(
        stream: FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryKey)
            .collection("products")
            .snapshots()
            .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
          return querySnapshot.docs.map(
              (QueryDocumentSnapshot<Map<String, dynamic>>
                  queryDocumentSnapshot) {
            return Product.fromSnapshot(queryDocumentSnapshot);
          }).toList();
        }),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              return ListView.separated(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                itemBuilder: (context, index) {
                  return ProductCard(product: snapshot.data![index]);
                },
                separatorBuilder: (context, index) {
                  return Container(color: Colors.black12, height: 0.5);
                },
              );
            default:
              return const Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}

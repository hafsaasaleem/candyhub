import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/features/customer/products/components/product_list.dart';
import 'package:towermarket/features/customer/products/components/shopping_cart_dialog.dart';
import 'package:towermarket/models/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TowermarketColors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Products"),
          ),
          body: StreamBuilder<List<Product>>(
            stream: FirebaseFirestore.instance
                .collection('products')
                .snapshots()
                .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
              return querySnapshot.docs.map(
                  (QueryDocumentSnapshot<Map<String, dynamic>>
                      queryDocumentSnapshot) {
                return Product.fromSnapshot(queryDocumentSnapshot);
              }).toList();
            }),
            builder: (_, AsyncSnapshot<List<Product>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  return Stack(
                    children: [
                      ProductList(products: snapshot.data!),
                      const ShoppingCartDialog(),
                    ],
                  );
                default:
                  return const Center(
                    child: Text("Something went wrong"),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

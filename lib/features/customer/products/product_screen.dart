import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/features/customer/shopping_cart/shopping_cart_screen.dart';
import 'package:towermarket/local_storage/item.dart';
import 'package:towermarket/models/product.dart';

class ProductScreen extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (_) => const ProductScreen());
  }

  const ProductScreen({Key? key}) : super(key: key);

  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, ShoppingCartScreen.route());
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: readAllInventry(),
        builder: (_, AsyncSnapshot<List<Product>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: snapshot.data?.length,
                itemBuilder: (_, index) {
                  final Product? product = snapshot.data?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl: product!.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(product.title),
                                  Text("PKR ${product.price}"),
                                ],
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Hive.box<Item>('shoppingcart').put(
                                      product.reference,
                                      Item(product: product.toMap()));
                                },
                                child: const Text("add"))
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            default:
              return const Center(
                child: Text("Something went wrong"),
              );
          }
        },
      ),
    );
  }

  Stream<List<Product>> readAllInventry() {
    return FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      return querySnapshot.docs.map(
          (QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
        return Product.fromSnapshot(queryDocumentSnapshot);
      }).toList();
    });
  }
}

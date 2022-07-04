import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/models/order.dart';
import 'package:towermarket/models/product.dart';
import 'package:towermarket/models/shopping_cart.dart';

class PlaceOrderScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const PlaceOrderScreen());
  }

  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  late final TextEditingController _address;
  late final List<Product> products;
  int totalAmount = 0;
  int totalProduct = 0;
  @override
  void initState() {
    super.initState();
    _address = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _address.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ValueListenableBuilder<Box<ShoppingCart>>(
                valueListenable:
                    Hive.box<ShoppingCart>('shoppingcart').listenable(),
                builder: (_, box, widget) {
                  // products = box.values
                  //     .toList()
                  //     .cast<ShoppingCart>()
                  //     .map((e) => e)
                  //     .toList();

                  for (var item in products) {
                    totalAmount += item.price;
                    totalProduct++;
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            TextField(
                              controller: _address,
                              keyboardType: TextInputType.streetAddress,
                              decoration: const InputDecoration(
                                hintText: "Address",
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("PKR $totalAmount"),
                        trailing: totalProduct < 10
                            ? Text("Total Item = 0$totalProduct")
                            : Text("Total Item = $totalProduct"),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                // await submitOrder();
              },
              child: const Text("Conferm Order"),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> submitOrder() async {
  //   final Order order = Order(
  //     createdAt: DateTime.now(),
  //     updatedAt: DateTime.now(),
  //     address: _address.text,
  //     total: totalAmount,
  //     totalItems: totalProduct,
  //     completed: false,
  //     status: false,
  //     products: products,
  //   );
  //   FirebaseFirestore.instance
  //       .collection("orders")
  //       .add(order.toMap())
  //       .then((value) => log("Successful: $value"))
  //       .onError((error, stackTrace) => log("Error $error"));
  // }
}

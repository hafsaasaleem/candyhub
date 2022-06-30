import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/local_storage/item.dart';
import 'package:towermarket/models/product.dart';
import 'package:towermarket/view/place_order_screen.dart';

class ShoppingCartScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const ShoppingCartScreen());
  }

  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ValueListenableBuilder<Box<Item>>(
                valueListenable: Hive.box<Item>('shoppingcart').listenable(),
                builder: (_, box, widget) {
                  List<Product> product = box.values
                      .toList()
                      .cast<Item>()
                      .map((e) => Product.fromMap(e.product))
                      .toList();
                  int totalAmount = 0;
                  int totalProduct = 0;
                  product.forEach((e) {
                    totalAmount += e.price;
                    totalProduct++;
                  });
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: product.length,
                          itemBuilder: (_, index) {
                            log(box.keys.map((e) => e).toList().toString());

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(product[index].imageUrl),
                              ),
                              title: Text(product[index].title),
                              subtitle: Text("PKR ${product[index].price}"),
                              trailing: TextButton(
                                  onPressed: () {
                                    Hive.box<Item>('shoppingcart')
                                        .delete(product[index].reference);
                                  },
                                  child: const Text("Remove")),
                            );
                          },
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
              onPressed: () {
                Navigator.push(context, PlaceOrderScreen.route());
              },
              child: const Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}

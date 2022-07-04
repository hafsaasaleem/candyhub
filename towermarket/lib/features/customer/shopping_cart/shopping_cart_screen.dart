import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/features/customer/shopping_cart/components/shopping_cart_tile.dart';
import 'package:towermarket/models/order.dart';
import 'package:towermarket/models/shopping_cart.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';
import 'package:towermarket/utilities/order_place_dialog.dart';
import 'package:towermarket/utilities/successfully_place_order_dialog.dart';

class ShoppingCartScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const ShoppingCartScreen());
  }

  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TowermarketColors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Shopping Cart"),
          ),
          body: ValueListenableBuilder<Box<ShoppingCart>>(
            valueListenable:
                Hive.box<ShoppingCart>('shoppingcart').listenable(),
            builder: (_, Box<ShoppingCart> state, widget) {
              final List<ShoppingCart> cart =
                  state.values.toList().cast<ShoppingCart>();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    cart.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: state.values.length,
                              itemBuilder: (_, index) {
                                return ShoppingCartTile(cart: cart[index]);
                              },
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: Text("No Item added Yet!",
                                  style: TowermarketTextStyle.title2),
                            ),
                          ),
                    ShoppingCartPlaceOrder(cart: cart),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ShoppingCartPlaceOrder extends StatelessWidget {
  final List<ShoppingCart> cart;
  const ShoppingCartPlaceOrder({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: cart.isNotEmpty
          ? () async {
              if (await showOrderPlaceDialog(context)) {
                if (await orderSubmit()) {
                  if (await showSuccessfullyOrderPlaceDialog(context)) {
                    Navigator.pop(context);
                  }
                } else {
                  Navigator.pop(context);
                }
              } else {
                Navigator.pop(context);
              }
            }
          : null,
      child: const Text("Place order"),
    );
  }

  Future<bool> orderSubmit() async {
    int totalAmount = 0;
    for (var element in cart) {
      int price = element.price * element.quantity;
      totalAmount += price;
    }
    try {
      FirebaseFirestore.instance.collection("orders").add(Order(
              updatedAt: DateTime.now(),
              createdAt: DateTime.now(),
              address: '',
              total: totalAmount,
              totalItems: cart.length,
              isCompleted: false,
              products: cart)
          .toMap());
    } catch (e) {
      log("Error $e");
    }
    return true;
  }
}

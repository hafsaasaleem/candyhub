import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/models/order.dart';
import 'package:towermarket/models/shopping_cart.dart';
import '../../utilities/order_place_dialog.dart';
import '../../utilities/successfully_place_order_dialog.dart';

class ShoppingCartPlaceOrder extends StatelessWidget {
  final List<ShoppingCart> cart;
  const ShoppingCartPlaceOrder({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: TowermarketColors.brick),
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

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/models/order.dart';

import '../order_details_screen.dart';

class NewOrders extends StatelessWidget {
  const NewOrders({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("orders")
          .where("completed", isEqualTo: false)
          .snapshots(),
      builder:
          (_, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            final List<Order> orders =
                snapshot.data!.docs.map((e) => Order.fromSnapshot(e)).toList();

            if (orders.isNotEmpty) {
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(context, OrderDetailsScreen.route());
                    },
                    leading: Text("${index + 1}"),
                    title: Text(orders[index].reference!),
                    subtitle: Text(orders[index].address),
                    trailing: Text("PKR ${orders[index].total}"),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("No, new Order"),
              );
            }

          default:
            return const Center(
              child: Text("Somethign went wrong"),
            );
        }
      },
    );
  }
}

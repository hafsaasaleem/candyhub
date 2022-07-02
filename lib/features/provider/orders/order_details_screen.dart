import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/models/order.dart';
import 'package:towermarket/pdf_api/pdf_api.dart';
import 'package:towermarket/pdf_api/pdf_invoice_api.dart';

import '../punch/invoice_preview_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const OrderDetailsScreen());
  }

  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: StreamBuilder<Order>(
        stream: readAllInventry(),
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              return OrderDetailsList(order: snapshot.data!);
            default:
              return const Center(
                child: Text("Something went wrong"),
              );
          }
        },
      ),
    );
  }

  Stream<Order> readAllInventry() {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      return Order.fromSnapshot(querySnapshot.docs[0]);
    });
  }
}

class OrderDetailsList extends StatelessWidget {
  final Order order;
  const OrderDetailsList({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("SR. NO")),
                  DataColumn(label: Text("TITLE")),
                  DataColumn(label: Text("BRAND")),
                  DataColumn(label: Text("SYMBOL")),
                  DataColumn(label: Text("PRICE 1")),
                  DataColumn(label: Text("QUANTITY")),
                  DataColumn(label: Text("PRICE 2")),
                ],
                rows: List.generate(order.products.length, (index) {
                  return DataRow(
                    cells: [
                      DataCell(Text("${index + 1}")),
                      DataCell(
                        Text(order.products[index].title),
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text("TITLE"),
                                  content: const TextField(),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("Update")),
                                  ],
                                );
                              });
                        },
                      ),
                      DataCell(Text(order.products[index].brand)),
                      DataCell(Text(order.products[index].symbol)),
                      DataCell(Text(order.products[index].price.toString())),
                      DataCell(Text(order.products[index].quantity.toString())),
                      DataCell(Text(
                          "${order.products[index].price * order.products[index].quantity}")),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ElevatedButton(
            onPressed: () async {
              final pdfFile = await PdfInvoiceApi.generate(order);
              PdfApi.openFile(pdfFile);
            },
            child: const Text("Order Punch"),
          ),
        ),
      ],
    );
  }
}

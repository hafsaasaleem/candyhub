import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/models/product.dart';

class InventryScreen extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (_) => const InventryScreen());
  }

  const InventryScreen({Key? key}) : super(key: key);

  @override
  State<InventryScreen> createState() => _InventryScreenState();
}

class _InventryScreenState extends State<InventryScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: readAllInventry(),
      builder: (_, snaps) {
        switch (snaps.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snaps.hasData) {
              return ProductsList(products: snaps.data!);
            } else {
              return const Center(child: Text("Empty"));
            }
          default:
            return const Center(
              child: Text("Something went wrong"),
            );
        }
      },
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

class ProductsList extends StatefulWidget {
  final List<Product> products;
  const ProductsList({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  late final TextEditingController _inputName;
  late final TextEditingController _inputQuantity;
  late final TextEditingController _inputPrice;

  @override
  void initState() {
    super.initState();
    _inputName = TextEditingController();
    _inputQuantity = TextEditingController();
    _inputPrice = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("NO#")),
          DataColumn(label: Text("NAME")),
          DataColumn(label: Text("QUANTITY")),
          DataColumn(label: Text("PRICE")),
        ],
        rows: List.generate(widget.products.length, (index) {
          return DataRow(
            cells: [
              DataCell(
                Text((index + 1).toString()),
              ),
              DataCell(
                Text(widget.products[index].title),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      _inputName.text = widget.products[index].title;
                      return AlertDialog(
                        actionsPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        insetPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        titlePadding: EdgeInsets.symmetric(vertical: 12),
                        buttonPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        title: const Text("Title", textAlign: TextAlign.center),
                        content: TextField(
                          controller: _inputName,
                          keyboardType: TextInputType.name,
                        ),
                        actions: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                child: const Text("Update"),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("products")
                                      .doc(widget.products[index].reference)
                                      .update({
                                    "title": _inputName.text,
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              DataCell(
                Text(widget.products[index].quantity.toString()),
                onTap: () {
                  _inputQuantity.text =
                      widget.products[index].quantity.toString();
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        actionsPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        insetPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        titlePadding: EdgeInsets.symmetric(vertical: 12),
                        buttonPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        title:
                            const Text("Quantity", textAlign: TextAlign.center),
                        content: TextField(
                          controller: _inputQuantity,
                          keyboardType: TextInputType.number,
                        ),
                        actions: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                child: const Text("Update"),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("products")
                                      .doc(widget.products[index].reference)
                                      .update({
                                    "quantity":
                                        int.tryParse(_inputQuantity.text) ?? 0
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              DataCell(
                Text(widget.products[index].price.toString()),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      _inputPrice.text =
                          widget.products[index].price.toString();
                      return AlertDialog(
                        actionsPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        insetPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        titlePadding: EdgeInsets.symmetric(vertical: 12),
                        buttonPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        title: const Text("Price", textAlign: TextAlign.center),
                        content: TextField(
                          controller: _inputPrice,
                          keyboardType: TextInputType.number,
                        ),
                        actions: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("products")
                                      .doc(widget.products[index].reference)
                                      .update({
                                    "price": int.tryParse(_inputPrice.text) ?? 0
                                  });
                                },
                                child: const Text("Update"),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

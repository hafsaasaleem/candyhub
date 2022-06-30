import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import 'update_inventry_screen.dart';

class ShowInventryScreen extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (_) => const ShowInventryScreen());
  }

  const ShowInventryScreen({Key? key}) : super(key: key);

  @override
  State<ShowInventryScreen> createState() => _ShowInventryScreenState();
}

class _ShowInventryScreenState extends State<ShowInventryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Show Inventry")),
      body: StreamBuilder<List<Product>>(
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
                return ListView.builder(
                  itemCount: snaps.data!.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text("${index + 1}"),
                          Expanded(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snaps.data![index].imageUrl),
                              ),
                              title: Text(snaps.data![index].title),
                              subtitle: Text(snaps.data![index].description),
                              trailing: Text("PKR ${snaps.data![index].price}"),
                              onTap: () {
                                Navigator.push(
                                    context, UpdateInventryScreen.route());
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text("Empty"));
              }
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

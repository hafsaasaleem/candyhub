import 'package:flutter/material.dart';
import 'package:towermarket/models/models.dart';
import '../../../service/service.dart';
import 'product_card.dart';

class ProductList extends StatelessWidget {
  ProductList({
    Key? key,
    required this.categoryKey,
  }) : super(key: key);

  final String categoryKey;
  final ProductFirebase _productFirebase = ProductFirebase();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<Iterable<Product>>(
        stream: _productFirebase.allCategories(documentId: categoryKey),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              return ListView.separated(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 72),
                itemBuilder: (context, index) {
                  return ProductCard(product: snapshot.data!.elementAt(index));
                },
                separatorBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    color: Colors.black12,
                    height: 0.5,
                  );
                },
              );
            default:
              return const Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}

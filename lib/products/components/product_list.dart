import 'package:flutter/material.dart';
import 'package:towermarket/models/product.dart';

import 'product_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      padding: const EdgeInsets.only(top: 8.0, bottom: 72, right: 12, left: 12),
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
      separatorBuilder: (context, index) {
        return Container(color: Colors.black12, height: 0.5);
      },
    );
  }
}

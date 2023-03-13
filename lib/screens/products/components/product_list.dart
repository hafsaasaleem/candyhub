import 'package:flutter/material.dart';
import 'package:candyhub/models/models.dart';
import 'package:candyhub/screens/products/components/components.dart';
import 'package:candyhub/widgets/widgets.dart';
import '../../../service/service.dart';

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
            return const Text(
              'Something went wrong',
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const ProductCardSkeletonList();
            case ConnectionState.active:
            case ConnectionState.done:
              return ListViewSeparated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: snapshot.data!.elementAt(index));
                },
              );
            default:
              return const Center(
                child: Text(
                  "Something went wrong",
                ),
              );
          }
        },
      ),
    );
  }
}

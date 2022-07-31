import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/models/shopping_cart.dart';
import '../components/components.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ValueNotifier<String> selectedCategoryKey = ValueNotifier("biscuit");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CategoryList(
                onChanged: (value) {
                  selectedCategoryKey.value = value;
                },
              ),
              ValueListenableBuilder<String>(
                valueListenable: selectedCategoryKey,
                builder: (context, state, widget) {
                  return ProductList(categoryKey: state);
                },
              ),
            ],
          ),
          ValueListenableBuilder<Box<ShoppingCart>>(
              valueListenable:
                  Hive.box<ShoppingCart>('shoppingcart').listenable(),
              builder: (_, state, widget) {
                return state.values.isNotEmpty
                    ? ShoppingCartDialog(
                        cart: state.values.toList().cast<ShoppingCart>())
                    : const Opacity(opacity: 0);
              }),
        ],
      ),
    );
  }
}

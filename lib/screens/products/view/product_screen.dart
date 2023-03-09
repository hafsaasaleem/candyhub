import 'package:flutter/cupertino.dart';
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
  late final ValueNotifier<String> selectedCategoryKey;

  @override
  void initState() {
    selectedCategoryKey = ValueNotifier("Candy");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("CandyHub"),
      ),
      drawer: Drawer(),
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
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                bottom: state.values.isNotEmpty ? 16 : 0,
                left: 16,
                right: 16,
                child: state.values.isNotEmpty
                    ? ShoppingCartDialog(
                        cart: state.values.toList().cast<ShoppingCart>())
                    : const Opacity(opacity: 0),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    selectedCategoryKey.dispose();
    super.dispose();
  }
}

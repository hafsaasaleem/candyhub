import 'package:flutter/material.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/products/components/category_list.dart';
import 'package:towermarket/products/components/shopping_cart_dialog.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';
import '../components/product_list.dart';

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
      backgroundColor: TowermarketColors.white,
      appBar: AppBar(
        titleTextStyle: TowermarketTextStyle.heading4
            .copyWith(color: TowermarketColors.white),
        backgroundColor: TowermarketColors.brick,
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
          const ShoppingCartDialog(),
        ],
      ),
    );
  }
}

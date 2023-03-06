import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/utilities/utilities.dart';
import '../components/components.dart';

class ShoppingCartScreen extends StatelessWidget {
  static Route route() {
    return CupertinoPageRoute(builder: (_) => const ShoppingCartScreen());
  }

  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TowermarketColors.brick,
        title: const Text(
          "Shopping Cart",
        ),
      ),
      body: const ShoppingCartItemsList(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:candyhub/utilities/utilities.dart';
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
        backgroundColor: CandyHubColors.purple,
        title: const Text(
          "Shopping Cart",
        ),
      ),
      body: const ShoppingCartItemsList(),
    );
  }
}

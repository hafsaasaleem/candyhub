import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/models/shopping_cart.dart';
import 'package:towermarket/utilities/utilities.dart';
import '../components/components.dart';

class ShoppingCartScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const ShoppingCartScreen());
  }

  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TowermarketColors.brick,
        title: const Text("Shopping Cart"),
      ),
      body: ValueListenableBuilder<Box<ShoppingCart>>(
        valueListenable: Hive.box<ShoppingCart>('shoppingcart').listenable(),
        builder: (_, Box<ShoppingCart> state, widget) {
          int totalAmount = 0;
          final List<ShoppingCart> cart =
              state.values.toList().cast<ShoppingCart>();
          for (var element in cart) {
            int price = element.price * element.count;
            totalAmount += price;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              cart.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.values.length,
                        itemBuilder: (_, index) {
                          return ShoppingCartTile(cart: cart[index]);
                        },
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text("No Item added Yet!",
                            style: TowermarketTextStyle.title2),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}

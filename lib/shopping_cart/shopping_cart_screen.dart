import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/models/shopping_cart.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';
import 'components/shopping_cart_place_order.dart';
import 'components/shopping_cart_tile.dart';

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
          final List<ShoppingCart> cart =
              state.values.toList().cast<ShoppingCart>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                cart.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
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
                ShoppingCartPlaceOrder(cart: cart),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/features/customer/shopping_cart/components/shopping_cart_tile.dart';
import 'package:towermarket/models/shopping_cart.dart';

class ShoppingCartScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const ShoppingCartScreen());
  }

  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TowermarketColors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Shopping Cart"),
          ),
          body: ValueListenableBuilder<Box<ShoppingCart>>(
            valueListenable:
                Hive.box<ShoppingCart>('shoppingcart').listenable(),
            builder: (_, Box<ShoppingCart> state, widget) {
              final List<ShoppingCart> cart =
                  state.values.toList().cast<ShoppingCart>();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.values.length,
                        itemBuilder: (_, index) {
                          return ShoppingCartTile(cart: cart[index]);
                        },
                      ),
                    ),
                    ShoppingCartPlaceOrder(cart: cart),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ShoppingCartPlaceOrder extends StatelessWidget {
  final List<ShoppingCart> cart;
  const ShoppingCartPlaceOrder({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("Place order"),
    );
  }
}

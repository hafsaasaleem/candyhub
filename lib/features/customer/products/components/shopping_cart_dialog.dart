import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/features/customer/shopping_cart/shopping_cart_screen.dart';
import 'package:towermarket/models/shopping_cart.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';

class ShoppingCartDialog extends StatelessWidget {
  const ShoppingCartDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<ShoppingCart>>(
      valueListenable: Hive.box<ShoppingCart>('shoppingcart').listenable(),
      builder: (_, state, widget) {
        int totalAmount = 0;
        final List<ShoppingCart> cart =
            state.values.toList().cast<ShoppingCart>();
        for (var element in cart) {
          int price = element.price * element.quantity;
          totalAmount += price;
        }
        return Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            decoration: BoxDecoration(
                color: TowermarketColors.peru,
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${cart.length} item",
                        style: TowermarketTextStyle.title2
                            .copyWith(color: TowermarketColors.white)),
                    Text("PKR $totalAmount",
                        style: TowermarketTextStyle.title2
                            .copyWith(color: TowermarketColors.white)),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, ShoppingCartScreen.route());
                  },
                  child: Row(
                    children: [
                      Text("View cart",
                          style: TowermarketTextStyle.title2
                              .copyWith(color: TowermarketColors.white)),
                      const Icon(Icons.keyboard_arrow_down_rounded,
                          color: TowermarketColors.white)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/models/shopping_cart.dart';
import 'package:towermarket/utilities/utilities.dart';
import 'package:towermarket/widgets/widgets.dart';

class ShoppingCartButtons extends StatelessWidget {
  const ShoppingCartButtons({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final ShoppingCart cart;

  @override
  Widget build(BuildContext context) {
    if (cart.count < 1) {
      Hive.box<ShoppingCart>('shoppingcart').delete(cart.reference);
    }
    return SizedBox(
      width: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CircleIconButton(
              icon: Icons.remove,
              onTap: () {
                if (cart.count > 0) {
                  Hive.box<ShoppingCart>('shoppingcart').put(
                      cart.reference, cart.copyWith(count: cart.count - 1));
                }
              },
            ),
          ),
          Expanded(
            child: Text(
              cart.count < 10 ? "0${cart.count}" : "${cart.count}",
              style: TowermarketTextStyle.title2,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: CircleIconButton(
              onTap: () {
                Hive.box<ShoppingCart>('shoppingcart')
                    .put(cart.reference, cart.copyWith(count: cart.count + 1));
              },
            ),
          ),
        ],
      ),
    );
  }
}

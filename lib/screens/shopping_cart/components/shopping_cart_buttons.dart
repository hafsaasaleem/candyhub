import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:candyhub/models/shopping_cart.dart';
import 'package:candyhub/utilities/utilities.dart';
import 'package:candyhub/widgets/widgets.dart';

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
      width: 66,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CircleIconButton(
              icon: Icons.remove,
              onTap: () {
                if (cart.count > 0) {
                  Hive.box<ShoppingCart>('shoppingcart').put(
                    cart.reference,
                    cart.copyWith(
                      count: cart.count - 1,
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Text(
              cart.count < 10 ? "0${cart.count}" : "${cart.count}",
              style: CandyHubTextStyle.title2,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: CircleIconButton(
              onTap: () {
                Hive.box<ShoppingCart>('shoppingcart').put(
                  cart.reference,
                  cart.copyWith(
                    count: cart.count + 1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

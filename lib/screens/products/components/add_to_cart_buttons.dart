import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/models/models.dart';
import 'package:towermarket/utilities/utilities.dart';
import 'package:towermarket/widgets/widgets.dart';

class AddToCartButtons extends StatelessWidget {
  const AddToCartButtons({
    Key? key,
    required this.cart,
    required this.product,
  }) : super(key: key);

  final Product product;
  final ShoppingCart? cart;

  @override
  Widget build(BuildContext context) {
    if (cart != null) {
      if (cart!.count < 1) {
        Hive.box<ShoppingCart>('shoppingcart').delete(cart!.reference);
      }
    }
    return cart != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleIconButton(
                icon: Icons.remove,
                onTap: () {
                  Hive.box<ShoppingCart>('shoppingcart').put(
                      cart!.reference, cart!.copyWith(count: cart!.count - 1));
                },
              ),
              const SizedBox(height: 6.0),
              Text(
                cart!.count < 10 ? "0${cart!.count}" : "${cart!.count}",
                style: TowermarketTextStyle.title3,
              ),
              const SizedBox(height: 6.0),
              CircleIconButton(
                onTap: () {
                  Hive.box<ShoppingCart>('shoppingcart').put(
                      cart!.reference, cart!.copyWith(count: cart!.count + 1));
                },
              )
            ],
          )
        : CircleIconButton(
            onTap: () {
              Hive.box<ShoppingCart>('shoppingcart').put(product.reference,
                  ShoppingCart.fromMap(product.toMap()).copyWith(count: 1));
            },
          );
  }
}

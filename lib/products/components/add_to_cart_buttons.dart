import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/models/product.dart';
import 'package:towermarket/models/shopping_cart.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';

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
      if (cart!.quantity == 0) {
        Hive.box<ShoppingCart>('shoppingcart').delete(cart!.reference);
      }
    }
    return cart != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Hive.box<ShoppingCart>('shoppingcart').put(cart!.reference,
                      cart!.copyWith(quantity: cart!.quantity - 1));
                },
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                    color: TowermarketColors.peru,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 18,
                    color: TowermarketColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                cart!.quantity < 10
                    ? "0${cart!.quantity}"
                    : "${cart!.quantity}",
                style: TowermarketTextStyle.title3,
              ),
              const SizedBox(height: 6.0),
              InkWell(
                onTap: () {
                  Hive.box<ShoppingCart>('shoppingcart').put(cart!.reference,
                      cart!.copyWith(quantity: cart!.quantity + 1));
                },
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                    color: TowermarketColors.peru,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 18,
                    color: TowermarketColors.white,
                  ),
                ),
              ),
            ],
          )
        : InkWell(
            onTap: () {
              Hive.box<ShoppingCart>('shoppingcart').put(product.reference,
                  ShoppingCart.fromMap(product.copyWith(quantity: 1).toMap()));
            },
            child: Container(
              padding: const EdgeInsets.all(6.0),
              decoration: const BoxDecoration(
                color: TowermarketColors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 18,
                color: TowermarketColors.white,
              ),
            ),
          );
  }
}

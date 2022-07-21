import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/models/shopping_cart.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';

class ShoppingCartButtons extends StatelessWidget {
  const ShoppingCartButtons({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final ShoppingCart cart;

  @override
  Widget build(BuildContext context) {
    if (cart.quantity == 0) {
      Hive.box<ShoppingCart>('shoppingcart').delete(cart.reference);
    }
    return SizedBox(
      width: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Hive.box<ShoppingCart>('shoppingcart').put(
                    cart.reference, cart.copyWith(quantity: cart.quantity - 1));
              },
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  color: TowermarketColors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.remove,
                  size: 12,
                  color: TowermarketColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            cart.quantity < 10 ? "0${cart.quantity}" : "${cart.quantity}",
            style: TowermarketTextStyle.title2,
          ),
          const SizedBox(width: 6.0),
          Expanded(
            child: InkWell(
              onTap: () {
                Hive.box<ShoppingCart>('shoppingcart').put(
                    cart.reference, cart.copyWith(quantity: cart.quantity + 1));
              },
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  color: TowermarketColors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  size: 12,
                  color: TowermarketColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // Row(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Container(
    //       width: 90,
    //       padding: const EdgeInsets.symmetric(vertical: 10),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(4.0),
    //         color: TowermarketColors.peru,
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           InkWell(
    //             onTap: () {
    //               Hive.box<ShoppingCart>('shoppingcart').put(cart.reference,
    //                   cart.copyWith(quantity: cart.quantity + 1));
    //             },
    //             child: const Icon(Icons.add, color: Colors.white, size: 18),
    //           ),
    //           Text(
    //             cart.quantity < 10 ? "0${cart.quantity}" : "${cart.quantity}",
    //             style: TowermarketTextStyle.title2
    //                 .copyWith(color: TowermarketColors.white),
    //             textAlign: TextAlign.center,
    //           ),
    //           InkWell(
    //             onTap: () {
    //               Hive.box<ShoppingCart>('shoppingcart').put(cart.reference,
    //                   cart.copyWith(quantity: cart.quantity - 1));
    //             },
    //             child: const Icon(Icons.remove, color: Colors.white, size: 18),
    //           ),
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }
}

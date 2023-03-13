import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:candyhub/models/models.dart';
import 'package:candyhub/utilities/utilities.dart';
import 'package:candyhub/widgets/widgets.dart';

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
    final ShoppingCart? item = cart;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: item == null
          ? CircleIconButton(
              onTap: () {
                Hive.box<ShoppingCart>('shoppingcart').put(
                  product.reference,
                  ShoppingCart.fromMap(product.toMap()).copyWith(
                    count: 1,
                  ),
                );
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleIconButton(
                  icon: Icons.remove,
                  onTap: () {
                    if (item.count > 0) {
                      Hive.box<ShoppingCart>('shoppingcart').put(
                          cart!.reference,
                          cart!.copyWith(count: cart!.count - 1));
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    item.count < 10 ? "0${item.count}" : "${item.count}",
                    style: CandyHubTextStyle.title3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: CircleIconButton(
                    onTap: () {
                      Hive.box<ShoppingCart>('shoppingcart').put(
                        item.reference,
                        item.copyWith(
                          count: item.count + 1,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );

    // if (cart != null) {
    //   // final ShoppingCart item = cart!;
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       CircleIconButton(
    //         icon: Icons.remove,
    //         onTap: () {
    //           if (item.count > 0) {
    //             Hive.box<ShoppingCart>('shoppingcart').put(
    //                 cart!.reference, cart!.copyWith(count: cart!.count - 1));
    //           }
    //         },
    //       ),
    //       const SizedBox(
    //         height: 6.0,
    //       ),
    //       Text(
    //         item.count < 10 ? "0${item.count}" : "${item.count}",
    //         style: candyhubTextStyle.title3,
    //       ),
    //       const SizedBox(
    //         height: 6.0,
    //       ),
    //       CircleIconButton(
    //         onTap: () {
    //           Hive.box<ShoppingCart>('shoppingcart').put(
    //             item.reference,
    //             item.copyWith(
    //               count: item.count + 1,
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   );
    // } else {
    //   return CircleIconButton(
    //     onTap: () {
    //       Hive.box<ShoppingCart>('shoppingcart').put(
    //         product.reference,
    //         ShoppingCart.fromMap(product.toMap()).copyWith(
    //           count: 1,
    //         ),
    //       );
    //     },
    //   );
    // }
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/models/models.dart';
import 'package:towermarket/utilities/utilities.dart';
import 'package:towermarket/widgets/widgets.dart';
import 'components.dart';

class ShoppingCartItemsList extends StatelessWidget {
  const ShoppingCartItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<ShoppingCart>>(
      valueListenable: Hive.box<ShoppingCart>('shoppingcart').listenable(),
      builder: (_, Box<ShoppingCart> state, widget) {
        final List<ShoppingCart> cart =
            state.values.toList().cast<ShoppingCart>();

        if (cart.isNotEmpty) {
          return ListViewSeparated(
            itemCount: state.values.length,
            itemBuilder: (context, index) {
              return ShoppingCartTile(cart: cart[index]);
            },
          );
        } else {
          return Center(
            child:
                Text("No Item added Yet!", style: TowermarketTextStyle.title2),
          );
        }
      },
    );
  }
}

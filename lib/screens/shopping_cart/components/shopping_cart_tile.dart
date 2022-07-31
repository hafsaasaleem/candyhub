import 'package:flutter/material.dart';
import 'package:towermarket/models/shopping_cart.dart';
import 'package:towermarket/utilities/utilities.dart';
import 'package:towermarket/widgets/widgets.dart';
import 'shopping_cart_buttons.dart';

class ShoppingCartTile extends StatelessWidget {
  const ShoppingCartTile({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final ShoppingCart cart;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 56,
        height: 56,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: TowermarketColors.black,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: CachedImage(imageUrl: cart.imageUrl),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cart.title, style: TowermarketTextStyle.title3),
          Text("${cart.quantity} ${cart.symbol}",
              style: TowermarketTextStyle.title5),
          const SizedBox(height: 4),
        ],
      ),
      subtitle: Text("PKR ${cart.price * cart.count}",
          style: TowermarketTextStyle.title5.copyWith(
            backgroundColor: TowermarketColors.black,
            color: TowermarketColors.white,
            fontWeight: FontWeight.w600,
          )),
      trailing: ShoppingCartButtons(cart: cart),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/models/shopping_cart.dart';
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
      // leading: CircleAvatar(
      //   backgroundImage: CachedNetworkImageProvider(
      //     cart.imageUrl),
      // ),
      leading: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: TowermarketColors.brick,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            width: 36,
            height: 36,
            placeholder: (_, err) {
              return ClipOval(
                child: CachedNetworkImage(
                  imageUrl: cart.imageUrl,
                ),
              );
            },
            imageUrl: cart.imageUrl,
          ),
        ),
      ),
      title: Text(cart.title),
      subtitle: Text("PKR ${cart.price}"),
      trailing: ShoppingCartButtons(cart: cart),
    );
  }
}

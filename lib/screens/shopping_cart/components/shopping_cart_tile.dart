import 'package:flutter/material.dart';
import 'package:candyhub/models/shopping_cart.dart';
import 'package:candyhub/utilities/utilities.dart';
import 'package:candyhub/widgets/widgets.dart';
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
            color: CandyHubColors.black,
            width: 0.5,
            style: BorderStyle.solid,
          ),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: CachedImage(
            imageUrl: cart.imageUrl,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cart.title,
            style: CandyHubTextStyle.title3,
          ),
          Text(
            "${cart.quantity} ${cart.symbol}",
            style: CandyHubTextStyle.title5,
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
      subtitle: Text(
        "PKR ${cart.price * cart.count}",
        style: CandyHubTextStyle.title3,
      ),
      trailing: ShoppingCartButtons(cart: cart),
    );
  }
}

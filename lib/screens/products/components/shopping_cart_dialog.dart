import 'package:flutter/material.dart';
import 'package:candyhub/models/models.dart';
import 'package:candyhub/screens/screens.dart';
import 'package:candyhub/utilities/utilities.dart';
import '../../login/login_screen.dart';

class ShoppingCartDialog extends StatelessWidget {
  final List<ShoppingCart> cart;
  const ShoppingCartDialog({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalAmount = 0;

    for (var element in cart) {
      int price = element.price * element.count;
      totalAmount += price;
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: CandyHubColors.purple,
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${cart.length} item",
                style: CandyHubTextStyle.title2.copyWith(
                  color: CandyHubColors.white,
                ),
              ),
              Text(
                "PKR $totalAmount",
                style: CandyHubTextStyle.title2.copyWith(
                  color: CandyHubColors.white,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, ShoppingCartScreen.route());
            },
            child: Row(
              children: [
                Text(
                  "View cart",
                  style: CandyHubTextStyle.title2.copyWith(
                    color: CandyHubColors.white,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: CandyHubColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

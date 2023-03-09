import 'package:flutter/material.dart';
import 'package:towermarket/models/models.dart';
import 'package:towermarket/screens/screens.dart';
import 'package:towermarket/utilities/utilities.dart';
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
        color: TowermarketColors.purple,
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
                style: TowermarketTextStyle.title2.copyWith(
                  color: TowermarketColors.white,
                ),
              ),
              Text(
                "PKR $totalAmount",
                style: TowermarketTextStyle.title2.copyWith(
                  color: TowermarketColors.white,
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
                  style: TowermarketTextStyle.title2.copyWith(
                    color: TowermarketColors.white,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: TowermarketColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

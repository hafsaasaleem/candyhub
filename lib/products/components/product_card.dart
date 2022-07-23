import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/models/product.dart';
import 'package:towermarket/typography/towermarket_text_style.dart';

import '../../models/shopping_cart.dart';
import 'add_to_cart_buttons.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    style: TowermarketTextStyle.title2,
                  ),
                  Text(
                    product.brand,
                    style: TowermarketTextStyle.title5,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${product.quantity} ${product.symbol}",
                    style: TowermarketTextStyle.title5,
                  ),
                  const SizedBox(height: 8),
                  Text("PKR ${product.price}",
                      style: TowermarketTextStyle.title2),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<ShoppingCart>>(
                valueListenable:
                    Hive.box<ShoppingCart>('shoppingcart').listenable(),
                builder: (_, Box<ShoppingCart> state, widget) {
                  return AddToCartButtons(
                    cart: state.get(product.reference),
                    product: product,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

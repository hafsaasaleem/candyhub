import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:towermarket/models/models.dart';
import 'package:towermarket/widgets/widgets.dart';
import 'add_to_cart_buttons.dart';
import 'package:towermarket/utilities/utilities.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CachedImage(
                    imageUrl: product.imageUrl,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: TowermarketTextStyle.title3,
                        maxLines: 2,
                      ),
                      Text(
                        product.brand,
                        style: TowermarketTextStyle.title5.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "${product.quantity} ${product.symbol}",
                        style: TowermarketTextStyle.title5,
                      ),
                      Text(
                        "PKR ${product.price}",
                        style: TowermarketTextStyle.title2,
                      ),
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
          const Divider(),
        ],
      ),
    );
  }
}

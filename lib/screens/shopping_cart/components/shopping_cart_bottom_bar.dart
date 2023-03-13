import 'package:flutter/material.dart';
import '../../../utilities/utilities.dart';
import '../../place_order/view/place_order_screen.dart';

class ShoppingCartBottomBar extends StatelessWidget {
  const ShoppingCartBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, PlaceOrderScreen.route());
        },
        child: Text(
          "Check out",
          style: CandyHubTextStyle.heading4,
        ),
      ),
    );
  }
}

















// class ShoppingCartBottomBar extends StatelessWidget {
//   const ShoppingCartBottomBar({
//     Key? key,
//     required this.cart,
//     required this.totalAmount,
//   }) : super(key: key);

//   final List<ShoppingCart> cart;
//   final int totalAmount;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Items Total",
//                 style: candyhubTextStyle.title2,
//               ),
//               Text(
//                 "${cart.length} items",
//                 style: candyhubTextStyle.title2,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 6,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Bill Total",
//                 style: candyhubTextStyle.title2,
//               ),
//               Text(
//                 "PKR $totalAmount",
//                 style: candyhubTextStyle.title2.copyWith(
//                   backgroundColor: candyhubColors.black,
//                   color: candyhubColors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

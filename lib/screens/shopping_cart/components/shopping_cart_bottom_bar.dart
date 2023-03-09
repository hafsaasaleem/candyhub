import 'package:flutter/material.dart';
import 'package:towermarket/screens/login/login_screen.dart';
import '../../../utilities/utilities.dart';

class ShoppingCartBottomBar extends StatelessWidget {
  const ShoppingCartBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, LoginScreen.route());
        },
        child: Text(
          "Login",
          style: TowermarketTextStyle.heading4,
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
//                 style: TowermarketTextStyle.title2,
//               ),
//               Text(
//                 "${cart.length} items",
//                 style: TowermarketTextStyle.title2,
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
//                 style: TowermarketTextStyle.title2,
//               ),
//               Text(
//                 "PKR $totalAmount",
//                 style: TowermarketTextStyle.title2.copyWith(
//                   backgroundColor: TowermarketColors.black,
//                   color: TowermarketColors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

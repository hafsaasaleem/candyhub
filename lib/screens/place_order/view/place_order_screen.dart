import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:candyhub/screens/payment_method/view/payment_method_screen.dart';
import 'package:candyhub/utilities/utilities.dart';

class PlaceOrderScreen extends StatelessWidget {
  static Route<PlaceOrderScreen> route() {
    return CupertinoPageRoute(builder: (context) => const PlaceOrderScreen());
  }

  const PlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 48),
                  Text(
                    "CandyHub",
                    textAlign: TextAlign.center,
                    style: CandyHubTextStyle.heading3,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Shop Name",
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Mobile Number",
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "City",
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Town",
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Adress",
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, PaymentMethodScreen.route());
              },
              child: Text(
                "Palce order",
                style: CandyHubTextStyle.heading4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

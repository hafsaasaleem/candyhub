import 'package:flutter/material.dart';
import 'package:towermarket/features/customer/products/view/product_screen.dart';
import 'package:towermarket/features/provider/home/home_screen.dart';

class SelectUser extends StatelessWidget {
  const SelectUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, HomeScreen.route());
              },
              child: const Text("Provider"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, ProductScreen.route());
              },
              child: const Text("Customer"),
            ),
          ],
        ),
      ),
    );
  }
}

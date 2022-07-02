import 'package:flutter/material.dart';
import 'package:towermarket/features/auth/login_screen.dart';
import 'package:towermarket/features/customer/products/product_screen.dart';
import 'package:towermarket/features/provider/home/home_screen.dart';

class SelectUserTypeScreen extends StatelessWidget {
  const SelectUserTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, ProductScreen.route());
              },
              child: const Text("Customer"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, HomeScreen.route());
              },
              child: const Text("Provider"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, LoginScreen.route());
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const AccountScreen());
  }

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: const Center(
        child: Text("Provider Account"),
      ),
    );
  }
}

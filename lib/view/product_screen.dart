import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (_) => const ProductScreen());
  }

  const ProductScreen({Key? key}) : super(key: key);

  @override
  ProductScreenState createState() => ProductScreenState();
}

class ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Screen")),
    );
  }
}

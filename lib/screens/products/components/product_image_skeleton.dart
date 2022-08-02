import 'package:flutter/material.dart';

class ProductImageSkeleton extends StatelessWidget {
  const ProductImageSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    );
  }
}

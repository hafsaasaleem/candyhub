import 'package:flutter/material.dart';
import 'package:towermarket/widgets/list_view_separated.dart';

class CategoryCardSkeletonList extends StatelessWidget {
  const CategoryCardSkeletonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListViewSeparated(
        separatedWidth: 18,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 6.0,
            ),
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: Colors.grey[300],
            ),
          );
        },
      ),
    );
  }
}

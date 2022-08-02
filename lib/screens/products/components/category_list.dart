import 'package:flutter/material.dart';
import 'package:towermarket/screens/products/components/components.dart';
import 'package:towermarket/widgets/widgets.dart';
import '../../../service/service.dart';
import 'category_card.dart';
import 'package:towermarket/utilities/utilities.dart';
import 'package:towermarket/models/models.dart';

class CategoryList extends StatelessWidget {
  final Function(String) onChanged;
  CategoryList({Key? key, required this.onChanged}) : super(key: key);

  final ValueNotifier<String> selectedCategory = ValueNotifier('biscuit');
  final CategoryFirebase _categoryFirebase = CategoryFirebase();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<Category>>(
      stream: _categoryFirebase.allCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
            'Something went wrong \nfrom Database',
            textAlign: TextAlign.center,
            style: TowermarketTextStyle.title1,
          ));
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const CategoryCardSkeletonList();
          case ConnectionState.active:
          case ConnectionState.done:
            return SizedBox(
              height: 46,
              child: ListViewSeparated(
                separatedWidth: 18,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: snapshot.data!.elementAt(index),
                    onChanged: onChanged,
                    selectedCategory: selectedCategory,
                  );
                },
              ),
            );
          default:
            return const Center(child: Text("Something went wrong"));
        }
      },
    );
  }
}

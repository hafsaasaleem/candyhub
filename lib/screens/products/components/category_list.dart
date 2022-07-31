import 'package:flutter/material.dart';
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
              child: Text('Something went wrong \nfrom Database',
                  textAlign: TextAlign.center,
                  style: TowermarketTextStyle.title1));
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            return SizedBox(
              height: 46,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                      category: snapshot.data!.elementAt(index),
                      onChanged: onChanged,
                      selectedCategory: selectedCategory);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 18);
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

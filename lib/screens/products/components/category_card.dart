import 'package:flutter/material.dart';
import 'package:towermarket/models/models.dart';
import 'package:towermarket/utilities/utilities.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({
    Key? key,
    required this.onChanged,
    required this.selectedCategory,
    required this.category,
  }) : super(key: key);

  final Function(String p1) onChanged;
  final ValueNotifier<String> selectedCategory;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedCategory,
      builder: (context, state, widget) {
        return ChoiceChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          side: const BorderSide(
            color: Colors.black12,
          ),
          backgroundColor: TowermarketColors.white,
          labelStyle: TowermarketTextStyle.title4,
          onSelected: (value) {
            onChanged(category.reference!);
            selectedCategory.value = category.reference!;
          },
          label: Text(
            category.name,
          ),
          selected: category.reference! == state,
        );
      },
    );
  }
}

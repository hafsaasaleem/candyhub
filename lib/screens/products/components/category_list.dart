import 'package:flutter/material.dart';
import 'package:candyhub/screens/products/components/components.dart';
import 'package:candyhub/widgets/widgets.dart';
import '../../../service/service.dart';
import 'package:candyhub/utilities/utilities.dart';
import 'package:candyhub/models/models.dart';

class CategoryList extends StatefulWidget {
  final Function(String) onChanged;
  const CategoryList({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late final ValueNotifier<String> _selectedCategory;
  final CategoryFirebase _categoryFirebase = CategoryFirebase();
  @override
  void initState() {
    _selectedCategory = ValueNotifier('Candy');
    super.initState();
  }

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
            style: CandyHubTextStyle.title1,
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
                    onChanged: widget.onChanged,
                    selectedCategory: _selectedCategory,
                  );
                },
              ),
            );
          default:
            return const Center(
              child: Text(
                "Something went wrong",
              ),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _selectedCategory.dispose();
    super.dispose();
  }
}

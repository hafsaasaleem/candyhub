import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import '../../models/category.dart';
import '../../typography/towermarket_text_style.dart';

class CategoryList extends StatelessWidget {
  final Function(String) onChanged;
  CategoryList({Key? key, required this.onChanged}) : super(key: key);

  final ValueNotifier<String> selectedCategory = ValueNotifier('biscuit');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
      stream: FirebaseFirestore.instance
          .collection('categories')
          .snapshots()
          .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        return querySnapshot.docs.map(
            (QueryDocumentSnapshot<Map<String, dynamic>>
                queryDocumentSnapshot) {
          return Category.fromSnapshot(queryDocumentSnapshot);
        }).toList();
      }),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
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
                  return InkWell(
                    onTap: () {
                      onChanged(snapshot.data![index].reference!);
                      selectedCategory.value = snapshot.data![index].reference!;
                    },
                    child: ValueListenableBuilder<String>(
                        valueListenable: selectedCategory,
                        builder: (context, state, widget) {
                          return Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: snapshot.data![index].reference! != state
                                  ? Border.all(
                                      color: Colors.black12,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(24),
                              color: snapshot.data![index].reference! == state
                                  ? Colors.black12
                                  : null,
                            ),
                            child: Text(snapshot.data![index].name,
                                style: TowermarketTextStyle.title3),
                          );
                        }),
                  );
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

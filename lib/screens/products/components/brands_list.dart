import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/models/models.dart';
import 'category_card.dart';
import 'package:towermarket/utilities/utilities.dart';

class BrandsList extends StatelessWidget {
  final Function(String) onChanged;
  BrandsList({Key? key, required this.onChanged}) : super(key: key);

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
        if (snapshot.hasError) {
          return Center(
              child: Text('Something went wrong \nfrom Database',
                  textAlign: TextAlign.center,
                  style: TowermarketTextStyle.title1));
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            return SizedBox(
              width: 60,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return RotatedBox(
                    quarterTurns: 3,
                    child: CategoryCard(
                        category: snapshot.data![index],
                        onChanged: onChanged,
                        selectedCategory: selectedCategory),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 18);
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
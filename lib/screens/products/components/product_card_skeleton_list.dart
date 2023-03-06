import 'package:flutter/material.dart';
import 'package:towermarket/widgets/list_view_separated.dart';

class ProductCardSkeletonList extends StatelessWidget {
  const ProductCardSkeletonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListViewSeparated(
      separatedHeight: 6,
      itemCount: 8,
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: 3 / 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  margin: const EdgeInsets.all(12),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.0),
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        margin: const EdgeInsets.all(24),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

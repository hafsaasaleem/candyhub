import 'package:flutter/material.dart';

class ListViewSeparated extends StatelessWidget {
  const ListViewSeparated({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.scrollDirection = Axis.vertical,
    this.separatedHeight,
    this.separatedWidth,
  }) : super(key: key);

  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final Axis scrollDirection;
  final double? separatedHeight;
  final double? separatedWidth;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: (context, index) {
        if (separatedHeight != null) {
          return SizedBox(height: separatedHeight);
        } else {
          return SizedBox(width: separatedWidth);
        }
      },
    );
  }
}

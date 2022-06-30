import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item {
  @HiveField(0)
  Map<String, dynamic> product;

  Item({
    required this.product,
  });
}

import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'shopping_cart.g.dart';

@HiveType(typeId: 1)
class ShoppingCart extends Equatable {
  @HiveField(0)
  final String? reference;
  @HiveField(1)
  final String brand;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final int count;
  @HiveField(5)
  final String title;
  @HiveField(6)
  final int quantity;
  @HiveField(7)
  final String symbol;
  const ShoppingCart({
    this.reference,
    required this.brand,
    required this.imageUrl,
    required this.price,
    this.count = 0,
    required this.title,
    required this.quantity,
    required this.symbol,
  });

  ShoppingCart copyWith({
    String? reference,
    String? brand,
    String? imageUrl,
    int? price,
    int? count,
    String? title,
    int? quantity,
    String? symbol,
  }) {
    return ShoppingCart(
      reference: reference ?? this.reference,
      brand: brand ?? this.brand,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      count: count ?? this.count,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      symbol: symbol ?? this.symbol,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'brand': brand,
      'imageUrl': imageUrl,
      'price': price,
      'count': count,
      'title': title,
      'quantity': quantity,
      'symbol': symbol,
    };
  }

  factory ShoppingCart.fromMap(Map<String, dynamic> map) {
    return ShoppingCart(
      reference: map['reference'],
      brand: map['brand'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price']?.toInt() ?? 0,
      count: map['count']?.toInt() ?? 0,
      title: map['title'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      symbol: map['symbol'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingCart.fromJson(String source) =>
      ShoppingCart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShoppingCart(reference: $reference, brand: $brand, imageUrl: $imageUrl, price: $price, count: $count, title: $title, quantity: $quantity, symbol: $symbol)';
  }

  @override
  List<Object?> get props {
    return [
      reference,
      brand,
      imageUrl,
      price,
      count,
      title,
      quantity,
      symbol,
    ];
  }
}

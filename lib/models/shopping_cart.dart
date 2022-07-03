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
  final String category;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final int price;
  @HiveField(6)
  final int quantity;
  @HiveField(7)
  final String symbol;
  @HiveField(8)
  final String title;
  @HiveField(9)
  final DateTime createdAt;
  @HiveField(10)
  final DateTime updatedAt;
  const ShoppingCart({
    this.reference,
    required this.brand,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.quantity,
    required this.symbol,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  ShoppingCart copyWith({
    String? reference,
    String? brand,
    String? category,
    String? imageUrl,
    String? description,
    int? price,
    int? quantity,
    String? symbol,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ShoppingCart(
      reference: reference ?? this.reference,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      symbol: symbol ?? this.symbol,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'brand': brand,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'quantity': quantity,
      'symbol': symbol,
      'title': title,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ShoppingCart.fromMap(Map<String, dynamic> map) {
    return ShoppingCart(
      reference: map['reference'],
      brand: map['brand'] ?? '',
      category: map['category'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      symbol: map['symbol'] ?? '',
      title: map['title'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingCart.fromJson(String source) => ShoppingCart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShoppingCart(reference: $reference, brand: $brand, category: $category, imageUrl: $imageUrl, description: $description, price: $price, quantity: $quantity, symbol: $symbol, title: $title, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object?> get props {
    return [
      reference,
      brand,
      category,
      imageUrl,
      description,
      price,
      quantity,
      symbol,
      title,
      createdAt,
      updatedAt,
    ];
  }
}
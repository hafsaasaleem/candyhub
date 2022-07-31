import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? reference;
  final bool inStock;
  final String brand;
  final String imageUrl;
  final int price;
  final String title;
  final String symbol;
  final int quantity;
  const Product({
    this.reference,
    required this.inStock,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.symbol,
    required this.quantity,
  });

  Product copyWith({
    String? reference,
    bool? inStock,
    String? brand,
    String? imageUrl,
    int? price,
    String? title,
    String? symbol,
    int? quantity,
  }) {
    return Product(
      reference: reference ?? this.reference,
      inStock: inStock ?? this.inStock,
      brand: brand ?? this.brand,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      title: title ?? this.title,
      symbol: symbol ?? this.symbol,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      // 'inStock': inStock,
      'brand': brand,
      'imageUrl': imageUrl,
      'price': price,
      'title': title,
      'symbol': symbol,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      reference: map['reference'],
      inStock: map['inStock'] ?? true,
      brand: map['brand'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price']?.toInt() ?? 0,
      title: map['title'] ?? '',
      symbol: map['symbol'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  factory Product.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final String reference = documentSnapshot.reference.id;
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return Product(
      inStock: map['inStock'] ?? true,
      reference: reference,
      brand: map['brand'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price']?.toInt() ?? 0,
      title: map['title'] ?? '',
      symbol: map['symbol'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      // updatedAt: (map["updatedAt"] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(reference: $reference, inStock: $inStock, brand: $brand, imageUrl: $imageUrl, price: $price, title: $title, symbol: $symbol, quantity: $quantity)';
  }

  @override
  List<Object?> get props {
    return [
      reference,
      inStock,
      brand,
      imageUrl,
      price,
      title,
      symbol,
      quantity,
    ];
  }
}

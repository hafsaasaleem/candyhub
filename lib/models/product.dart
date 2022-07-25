
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? reference;
  final String brand;
  final String imageUrl;
  final int price;
  final int quantity;
  final String symbol;
  final String title;
  const Product({
    this.reference,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.symbol,
    required this.title,
  });

  Product copyWith({
    String? reference,
    String? brand,
    String? imageUrl,
    int? price,
    int? quantity,
    String? symbol,
    String? title,
  }) {
    return Product(
      reference: reference ?? this.reference,
      brand: brand ?? this.brand,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      symbol: symbol ?? this.symbol,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'brand': brand,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'symbol': symbol,
      'title': title,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      reference: map['reference'],
      brand: map['brand'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      symbol: map['symbol'] ?? '',
      title: map['title'] ?? '',
    );
  }

  factory Product.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final String reference = documentSnapshot.reference.id;
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return Product(
      reference: reference,
      brand: map['brand'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      symbol: map['symbol'] ?? '',
      title: map['title'] ?? '',
      // updatedAt: (map["updatedAt"] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(reference: $reference, brand: $brand, imageUrl: $imageUrl, price: $price, quantity: $quantity, symbol: $symbol, title: $title)';
  }

  @override
  List<Object?> get props {
    return [
      reference,
      brand,
      imageUrl,
      price,
      quantity,
      symbol,
      title,
    ];
  }
}

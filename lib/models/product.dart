
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? reference;
  final String brand;
  final String category;
  final String imageUrl;
  final String description;
  final int price;
  final int quantity;
  final String symbol;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Product({
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

  Product copyWith({
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
    return Product(
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

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
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

  factory Product.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final String reference = documentSnapshot.reference.id;
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return Product(
      reference: reference,
      brand: map['brand'] ?? '',
      category: map['category'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      symbol: map['symbol'] ?? '',
      title: map['title'] ?? '',
      createdAt: (map["createdAt"] as Timestamp).toDate(),
      updatedAt: (map["updatedAt"] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(reference: $reference, brand: $brand, category: $category, imageUrl: $imageUrl, description: $description, price: $price, quantity: $quantity, symbol: $symbol, title: $title, createdAt: $createdAt, updatedAt: $updatedAt)';
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

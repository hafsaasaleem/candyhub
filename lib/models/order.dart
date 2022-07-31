import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:towermarket/models/shopping_cart.dart';

class Order extends Equatable {
  final String? reference;
  final DateTime updatedAt;
  final DateTime createdAt;
  final String address;
  final int total;
  final int totalItems;
  final bool isCompleted;
  final List<ShoppingCart> products;
  const Order({
    this.reference,
    required this.updatedAt,
    required this.createdAt,
    required this.address,
    required this.total,
    required this.totalItems,
    required this.isCompleted,
    required this.products,
  });

  Order copyWith({
    String? reference,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? address,
    int? total,
    int? totalItems,
    bool? isCompleted,
    List<ShoppingCart>? products,
  }) {
    return Order(
      reference: reference ?? this.reference,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      address: address ?? this.address,
      total: total ?? this.total,
      totalItems: totalItems ?? this.totalItems,
      isCompleted: isCompleted ?? this.isCompleted,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'reference': reference,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'address': address,
      'total': total,
      'totalItems': totalItems,
      'isCompleted': isCompleted,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      reference: map['reference'],
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      address: map['address'] ?? '',
      total: map['total']?.toInt() ?? 0,
      totalItems: map['totalItems']?.toInt() ?? 0,
      isCompleted: map['isCompleted'] ?? false,
      products: List<ShoppingCart>.from(
          map['products']?.map((x) => ShoppingCart.fromMap(x))),
    );
  }

  factory Order.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final String reference = documentSnapshot.reference.id;
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return Order(
      reference: reference,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      address: map['address'] ?? '',
      total: map['total']?.toInt() ?? 0,
      totalItems: map['totalItems']?.toInt() ?? 0,
      isCompleted: map['isCompleted'] ?? false,
      products: List<ShoppingCart>.from(
          map['products']?.map((x) => ShoppingCart.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(reference: $reference, updatedAt: $updatedAt, createdAt: $createdAt, address: $address, total: $total, totalItems: $totalItems, isCompleted: $isCompleted, products: $products)';
  }

  @override
  List<Object?> get props {
    return [
      reference,
      updatedAt,
      createdAt,
      address,
      total,
      totalItems,
      isCompleted,
      products,
    ];
  }
}

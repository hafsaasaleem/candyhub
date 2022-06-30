import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:towermarket/models/product.dart';

class Order extends Equatable {
  final String? reference;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String address;
  final int total;
  final int totalItems;
  final bool completed;
  final bool status;
  final List<Product> products;

  const Order({
    this.reference,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.total,
    required this.totalItems,
    required this.completed,
    required this.status,
    required this.products,
  });

  Order copyWith({
    String? reference,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? address,
    int? total,
    int? totalItems,
    bool? completed,
    bool? status,
    List<Product>? products,
  }) {
    return Order(
      reference: reference ?? this.reference,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      address: address ?? this.address,
      total: total ?? this.total,
      totalItems: totalItems ?? this.totalItems,
      completed: completed ?? this.completed,
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'address': address,
      'total': total,
      'totalItems': totalItems,
      'completed': completed,
      'status': status,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      reference: map['reference'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      address: map['address'] ?? '',
      total: map['total']?.toInt() ?? 0,
      totalItems: map['totalItems']?.toInt() ?? 0,
      completed: map['completed'] ?? false,
      status: map['status'] ?? false,
      products:
          List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
    );
  }

  factory Order.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final String reference = documentSnapshot.reference.id;
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return Order(
      reference: reference,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      address: map['address'] ?? '',
      total: map['total']?.toInt() ?? 0,
      totalItems: map['totalItems']?.toInt() ?? 0,
      completed: map['completed'] ?? false,
      status: map['status'] ?? false,
      products:
          List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Order(reference: $reference, createdAt: $createdAt, updatedAt: $updatedAt, address: $address, total: $total, totalItems: $totalItems, completed: $completed, status: $status, products: $products)';
  }

  @override
  List<Object?> get props {
    return [
      reference,
      createdAt,
      updatedAt,
      address,
      total,
      totalItems,
      completed,
      status,
      products,
    ];
  }
}

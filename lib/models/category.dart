import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String? reference;
  final String name;
  final String imageUrl;
  const Category({
    this.reference,
    required this.name,
    required this.imageUrl,
  });

  Category copyWith({
    String? reference,
    String? name,
    String? imageUrl,
  }) {
    return Category(
      reference: reference ?? this.reference,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      reference: map['reference'],
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  factory Category.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final String reference = documentSnapshot.reference.id;
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return Category(
      reference: reference,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() =>
      'Category(reference: $reference, name: $name, imageUrl: $imageUrl)';

  @override
  List<Object?> get props => [reference, name, imageUrl];
}

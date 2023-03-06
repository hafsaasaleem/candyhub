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



  factory Category.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final String reference = documentSnapshot.reference.id;
    final map = documentSnapshot.data() as Map<String, dynamic>;
    return Category(
      reference: reference,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }



  @override
  String toString() =>
      'Category(reference: $reference, name: $name, imageUrl: $imageUrl)';

  @override
  List<Object?> get props => [reference, name, imageUrl];
}

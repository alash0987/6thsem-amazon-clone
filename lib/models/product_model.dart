// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazonclone/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final List<Rating>? rating;
  final String? id;

  Product(
      {required this.name,
      required this.price,
      required this.description,
      required this.quantity,
      required this.category,
      required this.images,
      this.id,
      this.rating});
  //  rating

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'] ?? '',
        description: map['description'] ?? 0.0,
        quantity: map['quantity']?.toDouble() ?? '',
        images: List<String>.from(map['images']),
        category: map['category'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
        id: map['_id'] ?? '',
        rating: map['ratings'] != null
            ? List<Rating>.from(
                map['ratings']?.map(
                  (x) => Rating.fromMap(x),
                ),
              )
            : null);
  }
  String toJson() => json.encode(toMap());
  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}

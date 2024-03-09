import 'dart:convert';


class Product {
  final String vendorId;
  final String name;
  final String description;
  final String categoryId;
  final String image;
  final double purchasePrice;
  final double rentalPrice;
  final String purchaseUnit;
  final String rentalUnit;
  final String id;
  final double rating;
  Product({
      required this.vendorId,
      required this.name,
      required this.description,
      required this.categoryId,
      required this.image,
      required this.purchasePrice,
      required this.rentalPrice,
      required this.purchaseUnit,
      required this.rentalUnit,
      required this.id,
      required this.rating
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'image': image,
      'purchasePrice': purchasePrice,
      'rentalPrice': rentalPrice,
      'purchaseUnit': purchaseUnit,
      'rentalUnit': rentalUnit,
      'vendorId': vendorId,
      'rating': rating
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'],
      categoryId: map['categoryId'] ?? '',
      purchasePrice: map['purchasePrice']?.toDouble() ?? 0.0,
      rentalPrice: map['rentalPrice']?.toDouble() ?? 0.0,
      id: map['_id'],
      rating: map['rating']?.toDouble() ?? 0,
      vendorId: map['vendorId'] ?? '',
      purchaseUnit: map['purchaseUnit'] ?? '',
      rentalUnit: map['rentalUnit'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}

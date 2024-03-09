import 'dart:convert';

class MyCategory {
  final String id;
  final String name;
  final String image;

  MyCategory({required this.id, required this.name, required this.image});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "image": image
    };
  }

  factory MyCategory.fromMap(Map<String, dynamic> map) {
    return MyCategory(
      id: map['_id'] ?? '',
      image: map['image'] ?? '',
      name:  map['name'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory MyCategory.fromJson(String source) => MyCategory.fromMap(json.decode(source));
}

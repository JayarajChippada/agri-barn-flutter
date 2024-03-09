import 'dart:convert';

class Vendor {
  final String id;
  final String name;
  final String ownerName;
  final String pincode;
  final String address;
  final String phoneNumber;
  final String email;
  final bool serviceAvailable;
  final List<String> coverImages;
  final String token;
  final List<String> products;
  final int lat;
  final int long;
  final String type;

  Vendor(
      {required this.id,
      required this.token,
      required this.name,
      required this.ownerName,
      required this.pincode,
      required this.address,
      required this.phoneNumber,
      required this.email,
      required this.serviceAvailable,
      required this.coverImages,
      required this.products,
      required this.lat,
      required this.long,
      required this.type});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "ownerName": ownerName,
      "email": email,
      "pincode": pincode,
      "address": address,
      "phone": phoneNumber,
      "serviceAvailable": serviceAvailable,
      "coverImages": coverImages,
      "products": products,
      "lat": lat,
      "lng": long,
      "token": token,
      "type": type
    };
  }

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['user']['_id'] ?? '',
      name: map['user']['name'] ?? '',
      ownerName: map['user']['ownerName'] ?? '',
      email: map['user']['email'] ?? '',
      pincode: map['user']['pincode'] ?? '',
      address: map['user']['address'] ?? '',
      phoneNumber: map['user']['phone'] ?? '',
      serviceAvailable: true,
      token: map['token'] ?? '',
      lat: map['user']['lat'],
      long: map['user']['lng'],
      type: map['userType'],
      coverImages: map['user']['coverImages'] != null
          ? List<String>.from(map['user']['coverImages'])
          : [],
      products: map['user']['products'] != null
          ? List<String>.from(map['user']['products'])
          : [],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Vendor.fromJson(String source) {
    return Vendor.fromMap(json.decode(source));
  }

  Vendor copyWith(
      {String? id,
      String? name,
      String? ownerName,
      String? pincode,
      String? address,
      String? phoneNumber,
      String? email,
      bool? serviceAvailable,
      List<String>? coverImages,
      String? token,
      String? type,
      List<String>? products,
      int? lat,
      int? long}) {
    return Vendor(
        id: id ?? this.id,
        name: name ?? this.name,
        ownerName: ownerName ?? this.ownerName,
        email: email ?? this.email,
        pincode: pincode ?? this.pincode,
        address: address ?? this.address,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        serviceAvailable: serviceAvailable!,
        coverImages: coverImages ?? this.coverImages,
        token: token ?? this.token,
        products: products ?? this.products,
        lat: lat ?? this.lat,
        type: type ?? this.type,
        long: long ?? this.long);
  }
}

import 'dart:convert';

class User {
  final String id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String type;
  final String token;
  final bool verified;
  final List<dynamic> orders;
  final List<dynamic> cart;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.address,
      required this.type,
      required this.token,
      required this.verified,
      required this.orders,
      required this.cart});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "address": address,
      "phone": phoneNumber,
      "verified": verified,
      "orders": orders,
      "type": type,
      "token": token,
      "cart": cart
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user']['_id'] ?? '',
      firstName: map['user']['firstName'] ?? '',
      lastName: map['user']['lastName'] ?? '',
      email: map['user']['email'] ?? '',
      password: map['user']['password'] ?? '',
      address: map['user']['address'] ?? '',
      phoneNumber: map['user']['phone'] ?? '',
      verified: map['user']['verified'],
      type: map['userType'] ?? '',
      token: map['token'] ?? '',
      orders: map['user']['orders'] != null
          ? List<Map<String, dynamic>>.from(
              map['user']['orders']!.map((x) => Map<String, dynamic>.from(x)))
          : [],
      cart: map['user']['cart'] != null
          ? List<Map<String, dynamic>>.from(
              map['user']['cart']!.map((x) => Map<String, dynamic>.from(x)))
          : [],
    );
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory User.fromJson(String source) {
    return User.fromMap(json.decode(source));
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? address,
    String? phoneNumber,
    bool? verified,
    String? type,
    String? token,
    List<dynamic>? cart,
    List<dynamic>? orders,
  }) {
    return User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        address: address ?? this.address,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        verified: verified ?? this.verified,
        type: type ?? this.type,
        token: token ?? this.token,
        cart: cart ?? this.cart,
        orders: orders ?? this.orders);
  }
}

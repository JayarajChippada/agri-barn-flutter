import 'package:appathon/models/product_model.dart';



class Item {
  final Product product;
  final String type;
  final int unit;
  final String id;

  Item({
    required this.product,
    required this.type,
    required this.unit,
    required this.id,
  });

  

  factory Item.fromMap(Map<String, dynamic> json) {
    return Item(
      product: Product.fromMap(json['product']),
      type: json['type'],
      unit: json['unit'],
      id: json['_id'],
    );
  }
}

class Order {
  final String id;
  final String orderId;
  final String vendorId;
  final List<Item> items;
  final double totalAmount;
  final double paidAmount;
  final DateTime orderDate;
  final String orderStatus;
  final String remarks;
  final String farmerId;

  Order({
    required this.id,
    required this.orderId,
    required this.vendorId,
    required this.items,
    required this.totalAmount,
    required this.paidAmount,
    required this.orderDate,
    required this.orderStatus,
    required this.remarks,
    required this.farmerId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      orderId: json['orderID'],
      vendorId: json['vendorId'],
      items: (json['items'] as List)
          .map((itemJson) => Item.fromMap(itemJson))
          .toList(),
      totalAmount: json['totalAmount'].toDouble(),
      paidAmount: json['paidAmount'].toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      orderStatus: json['orderStatus'],
      remarks: json['remarks'],
      farmerId: json['farmerId'],
    );
  }
}


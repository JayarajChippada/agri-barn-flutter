// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:appathon/constants/error_handlings.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/models/orders_model.dart';
import 'package:appathon/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartServices {
  Future<List<Item>> getCart(BuildContext context) async {
    List<Item> cartList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response res = await http.get(
        Uri.parse('$uri/farmer/cart/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('x-auth-token')}'
        },
      );

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            cartList.add(
              Item.fromMap(jsonDecode(res.body)[i]),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return cartList;
  }

  void placeOrder(
      {required BuildContext context,
      required List<Item> cart,
      required int amount}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<dynamic> orderItems = [];
      for (int i = 0; i < cart.length; i++) {
        orderItems.add(OrderItem().toMap(
          id: cart[i].product.id,
          type: cart[i].type,
          unit: cart[i].unit.toDouble()
        ));
      }
      http.Response res = await http.post(Uri.parse('$uri/farmer/order'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${prefs.getString('x-auth-token')}'
          },
          body: jsonEncode({'amount': amount, 'items': orderItems}));

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          showSnackBar(context, "Order Created Successfully");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void removeFromCart(
      {required BuildContext context, required Product product}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response res = await http.delete(
          Uri.parse('$uri/api/remove-from-cart/${product.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${prefs.getString('x-auth-token')}'
          },
          body: jsonEncode({'id': product.id}));

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          showSnackBar(context, "Product is removed from cart successfully!");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

class OrderItem {
  // final String id;
  // final String type;
  // final double unit;

  // OrderItem({required this.id, required this.type, required this.unit});

  Map<String, dynamic> toMap({
    required String id, required String type, required double unit
  }) {
    return {
      "_id": id,
      "type": type,
      "unit": unit
    };
  }
}

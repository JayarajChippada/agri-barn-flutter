// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:appathon/constants/error_handlings.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/models/product_model.dart';
import 'package:appathon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsServices {
  void orderCompleted(
      {required BuildContext context, required String id}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(id);
      http.Response res = await http.patch(
        Uri.parse(
          "$uri/vendor/order-delivered/$id",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('x-auth-token')}'
        },
      );

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          showSnackBar(context, "Product added to Cart!");
        },
      );
    } catch (e) {
      //showSnackBar(context, e.toString());
    }
  }

  void addToCart(
      {required BuildContext context,
      required String id,
      required String type,
      required double unit}) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response res = await http.post(Uri.parse('$uri/farmer/cart'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${prefs.getString('x-auth-token')}'
          },
          body: jsonEncode({'_id': id, 'unit': unit, 'type': type}));

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          showSnackBar(context, "Product added to Cart!");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${user.token}'
          },
          body: jsonEncode({'id': product.id, 'rating': rating}));

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:appathon/constants/error_handlings.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/models/product_model.dart';
import 'package:appathon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchServices {
  Future<List<Product>> fetchSearchedProduct(
      {required BuildContext context, required String searchQuery}) async {

    //final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response res = await http.get(
        Uri.parse('$uri/farmer/product-by-category/$searchQuery'),
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
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchProductById(
      {required BuildContext context, required String searchQuery}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    Product product = Product(
        categoryId: "",
        description: "",
        image: "",
        id: "",
        name: "",
        purchasePrice: 0,
        purchaseUnit: "",
        rating: 0,
        rentalPrice: 0,
        rentalUnit: "",
        vendorId: "");
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/product/$searchQuery'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user.token}'
        },
      );

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          product = Product.fromJson(res.body);
          print(product.name);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}

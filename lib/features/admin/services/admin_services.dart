// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:appathon/constants/error_handlings.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/features/admin/models/sales.dart';
import 'package:appathon/features/admin/screens/admin_screen.dart';
import 'package:appathon/models/orders_model.dart';
import 'package:appathon/models/product_model.dart';
import 'package:appathon/providers/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminSevices {
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double purchasePrice,
      required double rentalPrice,
      required String rentalUnit,
      required String purchaseUnit,
      required String categoryId,
      required File image}) async {
    final user = Provider.of<VendorProvider>(context, listen: false).vendor;
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$uri/vendor/product'));
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields["purchasePrice"] = purchasePrice.toString();
      request.fields['rentalPrice'] = rentalPrice.toString();
      request.fields['purchaseUnit'] = purchaseUnit;
      request.fields['rentalUnit'] = rentalUnit;
      request.fields['categoryId'] = categoryId;
      request.headers['Authorization'] = 'Bearer ${user.token}';

      // Add image file
      var stream = http.ByteStream(image.openRead());
      var length = await image.length();

      var multipartFile = http.MultipartFile('image', stream, length,
          filename: basename(image.path));

      // Add the image file to the request
      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        showSnackBar(context, "Product added successfully!");
        Navigator.popAndPushNamed(context, AdminScreen.routeName);
      } else {
        showSnackBar(context,
            "Failed to add product. Status code: ${response.statusCode}");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final user = Provider.of<VendorProvider>(context, listen: false).vendor;
    List<Product> productList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response res = await http.get(
        Uri.parse('$uri/vendor/products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt'
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

  //delete a product
  void deleteAProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final user = Provider.of<VendorProvider>(context, listen: false).vendor;
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/vendor/product/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user.token}'
        },
      );

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all orders
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final user = Provider.of<VendorProvider>(context, listen: false).vendor;
    List<Order> ordersList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/vendor/orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user.token}'
        },
      );

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          List<dynamic> jsonResponse = jsonDecode(res.body);
          for (int i = 0; i < jsonResponse.length; i++) {
            
            ordersList.add(Order.fromJson(jsonResponse[i]));
            print(jsonResponse[i]);
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return ordersList;
  }

  void changeOrderStatus(
      {required BuildContext context,
      required int status,
      required Order order,
      required VoidCallback onSuccess}) async {
    final user = Provider.of<VendorProvider>(context, listen: false).vendor;
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user.token}'
        },
        body: jsonEncode({"productId": order.id, "status": status}),
      );

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all products
  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final user = Provider.of<VendorProvider>(context, listen: false).vendor;
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user.token}'
        },
      );

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales(label: 'Mobiles', earning: response['mobileEarnings']),
            Sales(label: 'Essentials', earning: response['essentialsEarnings']),
            Sales(label: 'Appliances', earning: response['appliancesEarnings']),
            Sales(label: 'Books', earning: response['booksEarnings']),
            Sales(label: 'Fashion', earning: response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {'sales': sales, "totalEarnings": totalEarning};
  }

  Future<List<dynamic>> fetchCategories(BuildContext context) async {
    final user = Provider.of<VendorProvider>(context, listen: false).vendor;
    List<dynamic> categorieList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/vendor/category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user.token}'
        },
      );

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          categorieList = jsonDecode(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return categorieList;
  }
}

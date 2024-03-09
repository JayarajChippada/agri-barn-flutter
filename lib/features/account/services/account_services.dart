// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:appathon/constants/error_handlings.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/features/auth/screens/auth_screen.dart';
import 'package:appathon/models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async {
    List<Order> orderList = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      
      http.Response res = await http.get(
        Uri.parse('$uri/farmer/orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer ${sharedPreferences.getString("x-auth-token")}"
        },
      );

      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          List<dynamic> jsonData = jsonDecode(res.body);
          orderList = jsonData.map((data) => Order.fromJson(data)).toList();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("x-auth-token", "");
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

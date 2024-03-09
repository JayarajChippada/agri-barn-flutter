// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:appathon/constants/error_handlings.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/models/user_model.dart';
import 'package:appathon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // Send the HTTP request
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({"address": address}),
      );

      // Handle the HTTP response
      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          User user = userProvider.user
              .copyWith(address: jsonDecode(res.body)['address']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalPrice}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // Send the HTTP request
      http.Response res = await http.post(
        Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer ${userProvider.user.token}"
        },
        body: jsonEncode({
          "cart": userProvider.user.cart,
          "address": address,
          "totalPrice": totalPrice
        }),
      );

      // Handle the HTTP response
      httpErrorHandles(
        context: context,
        response: res,
        onSuccess: () {
          showSnackBar(context, "Your Order has been placed!");
          User user = userProvider.user.copyWith(cart: []);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

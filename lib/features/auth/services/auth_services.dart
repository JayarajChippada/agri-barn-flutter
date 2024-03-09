// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:appathon/common/bottom_bar.dart';
import 'package:appathon/constants/error_handlings.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/features/admin/screens/admin_screen.dart';
import 'package:appathon/features/auth/screens/otp_screen.dart';
import 'package:appathon/models/product_model.dart';
import 'package:appathon/models/user_model.dart';
import 'package:appathon/providers/user_provider.dart';
import 'package:appathon/providers/vendor_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //sign up user
  void signUpUser(
      {required String email,
      required String password,
      required String phoneNumber,
      required BuildContext? context}) async {
    try {
      User user = User(
          id: "",
          firstName: "",
          lastName: "",
          email: email,
          password: password,
          address: "",
          phoneNumber: phoneNumber,
          type: "",
          token: "",
          verified: false,
          orders: [],
          cart: []);

      http.Response res = await http.post(
        Uri.parse('$uri/farmer/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      httpErrorHandles(
          response: res,
          context: context!,
          onSuccess: () async {
            showSnackBar(context, "Account created successfully!");
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                "x-auth-token", json.decode(res.body)['token']);
            Navigator.pushNamed(context, OtpScreen.routeName);
          });
    } catch (e) {
      showSnackBar(context!, e.toString());
    }
  }

  //sign in user
  void singInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/farmer/login"),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandles(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, "Login successfull!");
          //Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("x-auth-token", json.decode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
              context, MyBottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInVendor(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/vendor/login"),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandles(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, "Login sucessful!");
          Provider.of<VendorProvider>(context, listen: false).setUser(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("x-auth-token", json.decode(res.body)['token']);
          print(prefs.getString('x-auth-token'));
          Navigator.pushNamedAndRemoveUntil(
              context, AdminScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void verifyOtp({required String otp, required BuildContext context}) async {
    try {
      http.Response res = await http.post(Uri.parse("$uri/farmer/verify"),
          body: jsonEncode({'otp': otp}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      httpErrorHandles(
        response: res,
        context: context,
        onSuccess: () async {
          print(res);
          showSnackBar(context, "Otp Verified Successfully!");
          Navigator.pushReplacementNamed(context, MyBottomBar.routeName);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    List<Product> productList = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response res = await http.get(
        Uri.parse('$uri/farmer/products'),
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

  //get user data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = await prefs.getString("x-auth-token");
      if (token == null) {
        prefs.setString("x-auth-token", '');
      }

      http.Response res = await http
          .post(Uri.parse("$uri/farmer/profile"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token!}"
      });

      var response = json.decode(res.body);

      if (response == true) {
        // get user data
        http.Response userRes =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        });
        print(userRes);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

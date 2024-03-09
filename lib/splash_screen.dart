import 'dart:async';

import 'package:appathon/common/bottom_bar.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/features/admin/screens/admin_screen.dart';
import 'package:appathon/features/auth/screens/signup_screen.dart';
import 'package:appathon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
 @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.user.token.isNotEmpty) {
        if (userProvider.user.type == 'farer') {
          Navigator.of(context).pushReplacementNamed(MyBottomBar.routeName);
        } else {
          Navigator.of(context).pushReplacementNamed(AdminScreen.routeName);
        }
      } else {
        Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 50),
          color: GlobalVariables.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Buy and Sell agricultural inventory\nproducts",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: GlobalVariables.primaryTextColor,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Text(
                "AgriBarn",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    color: GlobalVariables.primaryTextColor,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

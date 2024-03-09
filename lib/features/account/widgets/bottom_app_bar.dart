import 'package:appathon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: RichText(
              text:  TextSpan(
                  text: "Hello,  ",
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                  children: [
                    TextSpan(
                      text: user.firstName, 
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ]
                ),
            ),
          ),
        ],
      ),
    );
  }
}

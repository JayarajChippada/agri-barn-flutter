import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/features/auth/screens/login_screen.dart';
import 'package:appathon/features/auth/screens/signup_screen.dart';
import 'package:appathon/features/auth/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void navigateToSignUp() {
    Navigator.pushNamed(context, SignUpScreen.routeName);
  }

  void navigateToSignIn() {
    Navigator.pushNamed(context, SignInScreen.routeName);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/welcome-image.png",
                      height: 220,
                      width: 220,
                    ),
                    const Text(
                      "Sign up to explore and shop directly\nfrom your community harvest's!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Monstserrat',
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: GlobalVariables.primaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    AuthButton(
                      text: "Sign up free",
                      color: GlobalVariables.primaryColor,
                      imgUrl: "",
                      ontap: navigateToSignUp,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthButton(
                      text: "Login",
                      imgUrl: "",
                      ontap: navigateToSignIn,
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

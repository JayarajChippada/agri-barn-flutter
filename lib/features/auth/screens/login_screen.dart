import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/features/auth/screens/signup_screen.dart';
import 'package:appathon/features/auth/services/auth_services.dart';
import 'package:appathon/features/auth/widgets/custom_button.dart';
import 'package:appathon/features/auth/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool toggle = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void navigateToSignUp() {
    Navigator.pushNamed(context, SignUpScreen.routeName);
  }

  void signInUser() {
    authService.singInUser(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  void signInVendor() {
    authService.signInVendor(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      Text(
                        toggle ? "Farmer Login" : "Vendor Login",
                        style: const TextStyle(
                          color: GlobalVariables.primaryTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  toggle = !toggle;
                                  
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: toggle
                                      ? Colors.green
                                      : null,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Center(
                                    child: Text(
                                      "Farmer",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  toggle = !toggle;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: toggle
                                      ? null
                                      : Colors.green,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Center(
                                    child: Text(
                                      "Vendor",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: "E-mail",
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          textInputType: TextInputType.text,
                          password: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: "Sign In",
                          onTap: toggle ? signInUser : signInVendor,
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                        //transition to sign up page
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: navigateToSignUp,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: const Text(
                                  "Sign Up.",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

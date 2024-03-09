import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/features/auth/screens/login_screen.dart';
import 'package:appathon/features/auth/services/auth_services.dart';
import 'package:appathon/features/auth/widgets/custom_button.dart';
import 'package:appathon/features/auth/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void navigateToSignIn() {
    Navigator.pushNamed(context, SignInScreen.routeName);
  }

  void signUpUser() {
    authService.signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
        phoneNumber: _phoneNumberController.text);
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
                  ), // logo image
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: GlobalVariables.primaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
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
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _phoneNumberController,
                          hintText: "Phone Number",
                          textInputType: TextInputType.phone
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: "Sign Up",
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
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
                                "Already have an account?",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: navigateToSignIn,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: const Text(
                                  "Log In.",
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

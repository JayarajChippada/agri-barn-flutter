import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/features/auth/services/auth_services.dart';
import 'package:appathon/features/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp-screen';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  FocusNode firstFocusNode = FocusNode();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void verifyOtp() {
    String otp = "${controllers[0].text}${controllers[1].text}${controllers[2].text}${controllers[3].text}";
    authService.verifyOtp(otp: otp, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 28,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Verify Phone Number",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Code Send To Your Phone Number",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: GlobalVariables.secondaryTextColor),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 60.0,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: controllers[index],
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                      //maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green.withOpacity(0.8)),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                      onEditingComplete: () {
                        if (controllers[index].text.isEmpty) {
                          if (index > 0) {
                            setState(() {
                              firstFocusNode.unfocus();
                              index = index - 1;
                            });
                          } else {
                            firstFocusNode.unfocus();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Transform.scale(
                scale: 0.95,
                child: CustomButton(
                    text: 'VERIFY',
                    onTap:verifyOtp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int maxlines;
  final bool password;
  final TextInputType textInputType;
  const CustomTextField(
    {super.key, 
    required this.hintText, 
    required this.controller, 
    this.maxlines = 1, 
    this.password = false, 
    required this.textInputType}
  );

  @override
  Widget build(BuildContext context) {
    const inputBorder =
          OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Color(0xFFE2E2E2)));
    return TextFormField(
      obscureText: password,
      maxLines: maxlines,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: 'Montserrat',
          ),
          hintText: '   $hintText',
          prefixText: '    ',
          border: inputBorder,
          enabledBorder: inputBorder
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}

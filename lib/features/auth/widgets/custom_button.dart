import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.color = const Color(0xFF208B3A)});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50), backgroundColor: color),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          text,
          style:
              const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                color: Colors.white, fontWeight: FontWeight.bold
              ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 0.0),
            borderRadius: BorderRadius.circular(50),
            color: Colors.green),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black12.withOpacity(0.03),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          onPressed: onTap,
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Color color;
  final String? imgUrl;
  final VoidCallback ontap;
  const AuthButton(
      {super.key, required this.text, this.color = Colors.white, this.imgUrl, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                width: 1.5,
                color: color == Colors.white ? Colors.black : color)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imgUrl != "")
              Image.asset(
                imgUrl!,
                height: 50,
                width: 50,
              ),
            if (imgUrl != "")
              const SizedBox(
                width: 20,
              ),
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: color == Colors.white ? Colors.black : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

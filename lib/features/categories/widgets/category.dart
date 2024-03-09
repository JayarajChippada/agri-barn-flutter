import 'package:flutter/material.dart';

class MyCategory extends StatelessWidget {
  final String image;
  final String text;
  const MyCategory({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              GestureDetector(
                child: Image.network(
                  image,
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 300,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.all(8),
                  child:  Center(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

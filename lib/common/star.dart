import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemCount: 5,
      direction: Axis.horizontal,
      rating: rating,
      itemSize: 15,
      itemBuilder: (context, index) {
        return const Icon(
          Icons.star,
          color: Colors.orange,
        );
      },
    );
  }
}

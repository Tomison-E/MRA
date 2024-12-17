import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    List<Widget> ratings = [];
    for (int i = 0; i < 5; i++) {
      ratings.add(
        Icon(
          Icons.star,
          color: i < rating ? kFFD700 : kGray4Color,
          size: 12,
        ),
      );
    }
    return Row(
      children: ratings,
    );
  }
}

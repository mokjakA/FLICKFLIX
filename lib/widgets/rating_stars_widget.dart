import 'package:flutter/material.dart';

class RatingStarsWidget extends StatelessWidget {
  final double rating;
  const RatingStarsWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    double normalizedRating = rating / 2; //10까지의 점수로 입력받음
    int fullStars = normalizedRating.floor();
    bool hasHalfStar = (normalizedRating - fullStars) >= 0.5;

    return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          if (index < fullStars) {
            return const Icon(Icons.star, color: Colors.amber);
          } else if (index == fullStars && hasHalfStar) {
            return const Icon(Icons.star_half, color: Colors.amber);
          } else {
            return const Icon(
              Icons.star_border,
              color: Colors.amber,
            );
          }
        }));
  }
}

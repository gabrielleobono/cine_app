import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating; // Note sur 5
  final double size;

  const RatingStars({super.key, required this.rating, this.size = 18});

  @override
  Widget build(BuildContext context) {
    // Récupération de la luminosité du thème pour adapter la couleur de fond des étoiles
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, size: size, color: Colors.amber);
        } else if (index < rating) {
          return Icon(Icons.star_half, size: size, color: Colors.amber);
        }
        return Icon(
          Icons.star_border,
          size: size,
          // Utilise une couleur grise adaptative pour rester visible en mode sombre ET clair
          color: isDark ? Colors.grey[600] : Colors.grey[400],
        );
      }),
    );
  }
}

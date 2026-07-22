import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'rating_stars.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  final bool isGrid;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return Card(
        clipBehavior: Clip.antiAlias, // Assure des angles arrondis parfaits
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    movie.posterEmoji,
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 1, // Évite la coupure ou la superposition
                      overflow:
                          TextOverflow.ellipsis, // Ajoute '...' si trop long
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${movie.genre} · ${movie.year}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    RatingStars(rating: movie.rating, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Text(movie.posterEmoji, style: const TextStyle(fontSize: 28)),
        title: Text(movie.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text('${movie.genre} · ${movie.year}'),
        trailing: RatingStars(rating: movie.rating),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'package:go_router/go_router.dart';
import '../widgets/rating_stars.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // affiche stylisée avec l'emoji, en grand
            Container(
              width: double.infinity,
              height: 180,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(movie.colorValue),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                movie.posterEmoji,
                style: const TextStyle(fontSize: 64),
              ),
            ),
            const SizedBox(height: 16),

            Text(movie.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text('${movie.genre} · ${movie.year} · ${movie.durationLabel}'),
            const SizedBox(height: 8),

            Row(
              children: [
                RatingStars(rating: movie.rating, size: 20),
                const SizedBox(width: 8),
                Text('${movie.rating} / 5'),
              ],
            ),
            const SizedBox(height: 16),

            Text('Réalisateur', style: Theme.of(context).textTheme.titleMedium),
            Text(movie.director),
            const SizedBox(height: 16),

            Text('Synopsis', style: Theme.of(context).textTheme.titleMedium),
            Text(movie.synopsis),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.pushNamed(
                    'addReview',
                    pathParameters: {'id': movie.id},
                  );
                },
                icon: const Icon(Icons.rate_review),
                label: const Text('Laisser un avis'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

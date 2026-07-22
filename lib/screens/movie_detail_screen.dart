import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/movie.dart';
import '../widgets/rating_stars.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // Calcul propre de la durée en heures et minutes
    final hours = movie.durationMinutes ~/ 60;
    final minutes = movie.durationMinutes % 60;
    final durationText = hours > 0
        ? '${hours}h ${minutes}min'
        : '${minutes}min';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // En-tête flexible qui remplace l'AppBar classique
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            backgroundColor: Color(movie.colorValue),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: const TextStyle(
                  shadows: [Shadow(blurRadius: 10.0, color: Colors.black54)],
                ),
              ),
              centerTitle: true,
              background: Container(
                color: Color(movie.colorValue),
                child: Center(
                  child: Text(
                    movie.posterEmoji,
                    style: const TextStyle(fontSize: 72),
                  ),
                ),
              ),
            ),
          ),

          // Contenu principal de l'écran enveloppé dans un SliverPadding
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text('${movie.genre} · ${movie.year} · $durationText'),
                const SizedBox(height: 8),

                Row(
                  children: [
                    RatingStars(rating: movie.rating, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${movie.rating} / 5',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Text(
                  'Réalisateur',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(movie.director),
                const SizedBox(height: 24),

                Text(
                  'Synopsis',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(movie.synopsis, style: const TextStyle(height: 1.4)),
                const SizedBox(height: 32),

                // Bouton d'action
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
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../data/movie_repository.dart';
import '../models/movie.dart';
import 'package:go_router/go_router.dart';
import '../widgets/movie_card.dart';
import '../widgets/genre_filter_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';
  String _selectedGenre = 'Tous';

  // Calcule dynamiquement le nombre de colonnes selon la largeur disponible
  int _getCrossAxisCount(double width) {
    if (width > 1200) return 5; // Grands écrans / PC de bureau
    if (width > 900) return 4; // Tablettes en mode paysage
    if (width > 600) return 3; // Petites tablettes / Grands téléphones paysage
    return 2; // Téléphones standards (mode grille optimisé)
  }

  @override
  Widget build(BuildContext context) {
    final repo = MovieRepository.instance;
    final List<Movie> results = repo.search(
      query: _query,
      genre: _selectedGenre,
    );
    final genres = ['Tous', ...repo.genres];

    // Récupération de la taille de l'écran pour adapter l'interface
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isMobilePortrait = screenWidth <= 480;

    return Scaffold(
      body: SafeArea(
        // Empêche les barres système de masquer le contenu (ex: encoche iPhone)
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('CinéScope'),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => context.pushNamed('settings'),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: GenreFilterBar(
                genres: genres,
                selectedGenre: _selectedGenre,
                onQueryChanged: (value) => setState(() => _query = value),
                onGenreSelected: (g) => setState(() => _selectedGenre = g),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            if (results.isEmpty)
              const SliverFillRemaining(
                hasScrollBody:
                    false, // Évite les bugs de défilement sur contenu vide
                child: Center(child: Text('Aucun film trouvé.')),
              )
            else if (isMobilePortrait)
              // Mode Liste verticale : Uniquement pour les petits téléphones en portrait
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final movie = results[index];
                  return MovieCard(
                    movie: movie,
                    isGrid: false,
                    onTap: () => context.pushNamed(
                      'movieDetail',
                      pathParameters: {'id': movie.id},
                    ),
                  );
                }, childCount: results.length),
              )
            else
              // Mode Grille adaptative : Pour les téléphones en paysage, tablettes et PC
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(screenWidth),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    // Ratio dynamique pour éviter que les images s'étirent de façon disproportionnée
                    childAspectRatio: screenWidth > 900 ? 0.7 : 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final movie = results[index];
                    return MovieCard(
                      movie: movie,
                      isGrid: true,
                      onTap: () => context.pushNamed(
                        'movieDetail',
                        pathParameters: {'id': movie.id},
                      ),
                    );
                  }, childCount: results.length),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

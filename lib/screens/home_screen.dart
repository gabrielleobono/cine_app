import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../widgets/movie_card.dart';
import '../widgets/genre_filter_bar.dart';
import '../providers/movie_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Calcule dynamiquement le nombre de colonnes selon la largeur disponible
  int _getCrossAxisCount(double width) {
    if (width > 1200) return 5; // Grands écrans / PC de bureau
    if (width > 900) return 4; // Tablettes en mode paysage
    if (width > 600) return 3; // Petites tablettes / Grands téléphones paysage
    return 2; // Téléphones standards (mode grille optimisé)
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieProvider>();
    final results = movieProvider.results;
    final genres = movieProvider.genres;

    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isMobilePortrait = screenWidth <= 480;

    return Scaffold(
      body: SafeArea(
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
                selectedGenre: movieProvider.selectedGenre,
                onQueryChanged: movieProvider.updateQuery,
                onGenreSelected: movieProvider.updateGenre,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            if (results.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('Aucun film trouvé.')),
              )
            else if (isMobilePortrait)
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

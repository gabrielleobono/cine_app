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
  int _getCrossAxisCount(double width) {
    if (width > 1200) return 5;
    if (width > 900) return 4;
    if (width > 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.watch<MovieProvider>();
    final results = movieProvider.results;
    final genres = movieProvider.genres;

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobilePortrait = screenWidth <= 480;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CinéScope'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.pushNamed('settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Votre widget réutilisable pour filtrer
            GenreFilterBar(
              genres: genres,
              selectedGenre: movieProvider.selectedGenre,
              onQueryChanged: movieProvider.updateQuery,
              onGenreSelected: movieProvider.updateGenre,
            ),
            const SizedBox(height: 8),

            // Contenu principal de la liste
            Expanded(
              child: results.isEmpty
                  ? const Center(child: Text('Aucun film trouvé.'))
                  : isMobilePortrait
                  ? ListView.builder(
                      // LISTVIEW
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final movie = results[index];
                        return MovieCard(
                          movie: movie,
                          isGrid: false,
                          onTap: () => context.pushNamed(
                            'movieDetail',
                            pathParameters: {'id': movie.id},
                          ),
                        );
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GridView.builder(
                        // GRIDVIEW
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _getCrossAxisCount(screenWidth),
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: screenWidth > 900 ? 0.7 : 0.75,
                        ),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final movie = results[index];
                          return MovieCard(
                            movie: movie,
                            isGrid: true,
                            onTap: () => context.pushNamed(
                              'movieDetail',
                              pathParameters: {'id': movie.id},
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

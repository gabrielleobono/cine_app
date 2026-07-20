import 'package:flutter/material.dart';
import '../data/movie_repository.dart';
import '../models/movie.dart';
import 'package:go_router/go_router.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';
  String _selectedGenre = 'Tous';

  @override
  Widget build(BuildContext context) {
    final repo = MovieRepository.instance;
    final List<Movie> results = repo.search(
      query: _query,
      genre: _selectedGenre,
    );
    final genres = ['Tous', ...repo.genres];
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('CinéScope'),
            floating: true,
            snap: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  context.pushNamed('settings');
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Rechercher un film...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: genres.map((g) {
                  final selected = g == _selectedGenre;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(g),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedGenre = g),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          if (results.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('Aucun film trouvé.')),
            )
          else if (isTablet)
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.8,
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
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final movie = results[index];
                return MovieCard(
                  movie: movie,
                  onTap: () => context.pushNamed(
                    'movieDetail',
                    pathParameters: {'id': movie.id},
                  ),
                );
              }, childCount: results.length),
            ),
        ],
      ),
    );
  }
}

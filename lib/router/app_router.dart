import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../screens/home_screen.dart';
import '../screens/movie_detail_screen.dart';
import '../screens/add_review_screen.dart';
import '../screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/movie/:id',
      name: 'movieDetail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final movie = context.read<MovieProvider>().getById(id);

        if (movie == null) {
          return const Scaffold(body: Center(child: Text('Film introuvable')));
        }
        return MovieDetailScreen(movie: movie);
      },
    ),
    GoRoute(
      path: '/movie/:id/review',
      name: 'addReview',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final movie = context.read<MovieProvider>().getById(id);

        if (movie == null) {
          return const Scaffold(body: Center(child: Text('Film introuvable')));
        }
        return AddReviewScreen(movieId: movie.id, movieTitle: movie.title);
      },
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

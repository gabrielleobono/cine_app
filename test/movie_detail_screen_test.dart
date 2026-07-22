import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cine_app/screens/movie_detail_screen.dart';
import 'package:cine_app/data/movie_repository.dart';

void main() {
  testWidgets(
    'MovieDetailScreen affiche le titre, le réalisateur et le synopsis',
    (WidgetTester tester) async {
      final movie = MovieRepository.instance.getAll().first;

      await tester.pumpWidget(
        MaterialApp(home: MovieDetailScreen(movie: movie)),
      );

      expect(find.text(movie.title), findsWidgets);
      expect(find.text(movie.director), findsOneWidget);
      expect(find.text(movie.synopsis), findsOneWidget);
      expect(find.text('Laisser un avis'), findsOneWidget);
    },
  );
}

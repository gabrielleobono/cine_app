import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cine_app/screens/movie_detail_screen.dart';
import 'package:cine_app/models/movie.dart';

void main() {
  testWidgets(
    'MovieDetailScreen affiche le titre, le réalisateur et le synopsis',
    (WidgetTester tester) async {
      // Création d'une entité isolée pour éviter de dépendre du JSON asynchrone
      const fakeMovie = Movie(
        id: 'test',
        title: 'Film Test',
        genre: 'Drame',
        year: 2026,
        rating: 4.0,
        durationMinutes: 120,
        director: 'Réalisateur Test',
        synopsis: 'Un synopsis de test de plus de dix caractères.',
        posterEmoji: '🎬',
        colorValue: 0xFF3949AB,
      );

      await tester.pumpWidget(
        const MaterialApp(home: MovieDetailScreen(movie: fakeMovie)),
      );

      expect(find.text(fakeMovie.title), findsWidgets);
      expect(find.text(fakeMovie.director), findsOneWidget);
      expect(find.text(fakeMovie.synopsis), findsOneWidget);
      expect(find.text('Laisser un avis'), findsOneWidget);
    },
  );
}

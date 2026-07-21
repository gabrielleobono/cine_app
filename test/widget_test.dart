import 'package:flutter_test/flutter_test.dart';
import 'package:cine_app/data/movie_repository.dart';

void main() {
  group('MovieRepository.search', () {
    final repo = MovieRepository.instance;

    test('renvoie tous les films quand query et genre sont vides', () {
      final results = repo.search();
      expect(results.length, repo.getAll().length);
    });

    test('filtre par titre, insensible à la casse', () {
      final results = repo.search(query: 'blade');
      expect(results.length, 1);
      expect(results.first.title, contains('Blade Runner'));
    });

    test('filtre par genre', () {
      final results = repo.search(genre: 'Science-Fiction');
      expect(results.every((m) => m.genre == 'Science-Fiction'), true);
    });

    test('combine texte et genre en même temps', () {
      final results = repo.search(query: 'dune', genre: 'Science-Fiction');
      expect(results.length, 1);
    });

    test('renvoie une liste vide si rien ne correspond', () {
      final results = repo.search(query: 'film qui n\'existe pas');
      expect(results, isEmpty);
    });
  });
}

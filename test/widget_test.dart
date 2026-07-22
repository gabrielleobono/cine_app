import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:cine_app/data/movie_repository.dart';

void main() {
  // Obligatoire pour initialiser les liaisons de test Flutter
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MovieRepository.search', () {
    final repo = MovieRepository.instance;

    setUpAll(() async {
      // Mock du canal d'assets pour renvoyer un faux JSON pendant le test unitaire
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
            MethodCall methodCall,
          ) async {
            return '[{"id":"m1","title":"Blade Runner","genre":"Science-Fiction","year":1982,"rating":4.5,"durationMinutes":132,"director":"Ridley Scott","synopsis":"Futur.","posterEmoji":"🤖","colorValue":4281944507},{"id":"m5","title":"Dune","genre":"Science-Fiction","year":2021,"rating":4.6,"durationMinutes":121,"director":"Denis V.","synopsis":"Sable.","posterEmoji":"🏜️","colorValue":4291143720}]';
          });

      // Initialise le dépôt avec le mock ci-dessus
      await repo.init();
    });

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

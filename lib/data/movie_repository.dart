import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/movie.dart';

class MovieRepository {
  MovieRepository._();
  static final MovieRepository instance = MovieRepository._();

  // Liste interne initialement vide
  final List<Movie> _movies = [];

  // Indicateur pour s'assurer que le chargement n'est fait qu'une fois
  bool _isInitialized = false;

  /// Charge les données depuis le fichier JSON des assets.
  /// Doit être appelé au démarrage (ex: dans le main ou le initState du premier écran)
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      final String response = await rootBundle.loadString('assets/movies.json');
      final List<dynamic> data = json.decode(response);

      _movies.clear();
      for (final item in data) {
        _movies.add(Movie.fromJson(item));
      }
      _isInitialized = true;
    } catch (e) {
      throw Exception('Impossible de charger le fichier JSON des films : $e');
    }
  }

  // Renvoie la liste chargée en mémoire (lève une erreur si init() n'a pas été appelé)
  List<Movie> getAll() {
    _checkInitialized();
    return List.unmodifiable(_movies);
  }

  Movie? getById(String id) {
    _checkInitialized();
    for (final m in _movies) {
      if (m.id == id) return m;
    }
    return null;
  }

  List<String> get genres {
    _checkInitialized();
    final set = <String>{};
    for (final m in _movies) {
      set.add(m.genre);
    }
    return set.toList()..sort();
  }

  List<Movie> search({String query = '', String? genre}) {
    _checkInitialized();
    return _movies.where((m) {
      final matchesQuery = m.title.toLowerCase().contains(query.toLowerCase());
      final matchesGenre = genre == null || genre == 'Tous' || m.genre == genre;
      return matchesQuery && matchesGenre;
    }).toList();
  }

  Color colorOf(Movie m) => Color(m.colorValue);

  void _checkInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'Le MovieRepository doit être initialisé avec init() avant d\'accéder aux données.',
      );
    }
  }
}

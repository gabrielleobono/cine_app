import 'package:flutter/material.dart';
import '../data/movie_repository.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  bool _isLoading = true;
  String _errorMessage = '';
  List<Movie> _movies = [];

  // Variables pour gérer l'état des filtres et de la recherche
  String _query = '';
  String _selectedGenre = 'Tous';

  // Getters de base requis par main.dart
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<Movie> get movies => _movies;

  // 1. Getters requis par home_screen.dart
  String get selectedGenre => _selectedGenre;

  List<String> get genres {
    // Récupère la liste triée des genres depuis le repository
    try {
      final repositoryGenres = MovieRepository.instance.genres;
      // On s'assure que 'Tous' est présent en premier choix
      return ['Tous', ...repositoryGenres];
    } catch (_) {
      return ['Tous'];
    }
  }

  // Renvoie les films filtrés par texte ET par genre (exigé par votre home_screen)
  List<Movie> get results {
    return MovieRepository.instance.search(
      query: _query,
      genre: _selectedGenre,
    );
  }

  MovieProvider() {
    _initRepository();
  }

  Future<void> _initRepository() async {
    try {
      await MovieRepository.instance.init();
      _movies = MovieRepository.instance.getAll();
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Erreur lors du chargement des données : $e';
    }
    notifyListeners();
  }

  // 2. Méthodes de recherche et filtrage requises par home_screen.dart
  void updateQuery(String newQuery) {
    _query = newQuery;
    notifyListeners(); // Rafraîchit l'interface (CustomScrollView) automatiquement
  }

  void updateGenre(String newGenre) {
    _selectedGenre = newGenre;
    notifyListeners(); // Force la reconstruction des Slivers avec la nouvelle liste filtrée
  }

  // 3. Méthode requise par app_router.dart pour afficher l'écran de détails
  Movie? getById(String id) {
    return MovieRepository.instance.getById(id);
  }
}

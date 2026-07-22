import 'package:flutter/material.dart';
import '../data/movie_repository.dart';
import '../models/movie.dart';

class MovieProvider extends ChangeNotifier {
  final MovieRepository _repository = MovieRepository.instance;

  String _query = '';
  String _selectedGenre = 'Tous';

  String get query => _query;
  String get selectedGenre => _selectedGenre;

  List<String> get genres => ['Tous', ..._repository.genres];

  List<Movie> get results =>
      _repository.search(query: _query, genre: _selectedGenre);

  Movie? getById(String id) => _repository.getById(id);

  void updateQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void updateGenre(String value) {
    _selectedGenre = value;
    notifyListeners();
  }
}

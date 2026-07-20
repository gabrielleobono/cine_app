import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieRepository {
  MovieRepository._();
  static final MovieRepository instance = MovieRepository._();

  final List<Movie> _movies = [
    Movie(
      id: 'm1',
      title: 'Blade Runner',
      genre: 'Science-Fiction',
      year: 1982,
      rating: 4.5,
      durationMinutes: 132,
      director: 'Ridley Scott',
      synopsis:
          "Dans un futur dystopique, un détective traque des androïdes rebelles dans les rues de Los Angeles.",
      posterEmoji: '',
      colorValue: 0xFF3949AB,
    ),
    Movie(
      id: 'm2',
      title: 'Le Sentier de Cuivre',
      genre: 'Drame',
      year: 2022,
      rating: 4.8,
      durationMinutes: 118,
      director: 'Jean-Paul Mbarga',
      synopsis:
          "Une jeune ingénieure se bat pour moderniser l'exploitation minière familiale.",
      posterEmoji: '🎭',
      colorValue: 0xFF6D4C41,
    ),
    Movie(
      id: 'm3',
      title: 'Rire Sous la Pluie',
      genre: 'Comédie',
      year: 2023,
      rating: 4.1,
      durationMinutes: 97,
      director: 'Sophie Etoa',
      synopsis:
          "Deux colocataires organisent le plus grand mariage de la ville en une semaine.",
      posterEmoji: '🎬',
      colorValue: 0xFFF9A825,
    ),
    Movie(
      id: 'm4',
      title: '2001: L\'Odyssée de l\'espace',
      genre: 'Science-Fiction',
      year: 1968,
      rating: 3.9,
      durationMinutes: 104,
      director: 'Stanley Kubrick',
      synopsis:
          "Un voyage interstellaire qui explore l'évolution humaine et la rencontre avec une intelligence extraterrestre.",
      posterEmoji: '',
      colorValue: 0xFF4E342E,
    ),
    Movie(
      id: 'm5',
      title: 'Dune ',
      genre: 'Science-Fiction',
      year: 2021,
      rating: 4.6,
      durationMinutes: 121,
      director: 'Denis Villeneuve',
      synopsis:
          "Dans un futur lointain, un jeune héritier lutte pour protéger sa planète et son peuple contre des forces interstellaires.",
      posterEmoji: '',
      colorValue: 0xFFC62828,
    ),
  ];

  List<Movie> getAll() => List.unmodifiable(_movies);

  Movie? getById(String id) {
    for (final m in _movies) {
      if (m.id == id) return m;
    }
    return null;
  }

  List<String> get genres {
    final set = <String>{};
    for (final m in _movies) {
      set.add(m.genre);
    }
    return set.toList()..sort();
  }

  List<Movie> search({String query = '', String? genre}) {
    return _movies.where((m) {
      // Vrai si le titre du film contient le texte tapé (peu importe majuscules/minuscules)
      final matchesQuery = m.title.toLowerCase().contains(query.toLowerCase());

      // Vrai dans 3 cas : pas de genre choisi (null), genre = "Tous", ou genre exactement égal
      final matchesGenre = genre == null || genre == 'Tous' || m.genre == genre;

      // Le film n'est gardé que si LES DEUX conditions sont vraies
      return matchesQuery && matchesGenre;
    }).toList();
  }

  Color colorOf(Movie m) => Color(m.colorValue);
}

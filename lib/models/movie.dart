class Movie {
  final String id;
  final String title;
  final String genre;
  final int year;
  final double rating;
  final int durationMinutes;
  final String director;
  final String synopsis;
  final String posterEmoji;
  final int colorValue;

  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.year,
    required this.rating,
    required this.durationMinutes,
    required this.director,
    required this.synopsis,
    required this.posterEmoji,
    required this.colorValue,
  });

  String get durationLabel {
    final h = durationMinutes ~/ 60;
    final m = durationMinutes % 60;
    return '${h}h${m.toString().padLeft(2, '0')}';
  }
}

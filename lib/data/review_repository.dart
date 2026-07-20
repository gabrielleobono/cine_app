import '../models/review.dart';

class ReviewRepository {
  ReviewRepository._();
  static final ReviewRepository instance = ReviewRepository._();

  final List<Review> _reviews = [];

  List<Review> getAll() => List.unmodifiable(_reviews);

  List<Review> forMovie(String movieId) =>
      _reviews.where((r) => r.movieId == movieId).toList();

  void add(Review review) {
    _reviews.add(review);
  }
}

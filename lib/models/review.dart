class Review {
  final String movieId;
  final String reviewerName;
  final int stars;
  final String comment;
  final DateTime createdAt;

  const Review({
    required this.movieId,
    required this.reviewerName,
    required this.stars,
    required this.comment,
    required this.createdAt,
  });
}

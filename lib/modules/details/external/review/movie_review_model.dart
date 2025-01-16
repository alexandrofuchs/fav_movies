part of 'movie_review_repository.dart';

extension MovieReviewModel on MovieReview {
  toTableModel() =>
      {'movie_id': movieId, 'rating': rate, 'description': description};

  static fromTableMap(Map<String, dynamic> map) => MovieReview(
      movieId: map['movie_id'],
      rate: map['rating'],
      description: map['description']);
}

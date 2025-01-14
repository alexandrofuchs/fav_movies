part of 'review_movie_repository.dart';

extension MovieDetailsModel on MovieReview {
  toTableModel() => {
      'movie_id': movieId,
      'rating': rate,
      'description': description
  };
}

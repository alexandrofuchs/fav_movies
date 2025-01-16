import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/details/domain/i_repositories/i_movie_review_repository.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';
import 'package:sqflite/sqflite.dart';

part 'movie_review_model.dart';


class MovieReviewRepository implements IMovieReviewRepository {
  final Database _database;

  MovieReviewRepository(this._database);

  @override
  Future<ResponseStatus> saveReview(MovieReview review) async {
    final response = await _database.insert('MovieReviews', review.toTableModel(), conflictAlgorithm: ConflictAlgorithm.replace);

    return ResponseStatus(code: response, message: 'ok');
  }
  
  @override
  Future<MovieReview> getReview(int movieId) async {
    final response = await _database.query('MovieReviews', where: 'movie_id = ?', whereArgs: [movieId]);
    return MovieReviewModel.fromTableMap(response.first);
  }
}

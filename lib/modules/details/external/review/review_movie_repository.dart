import 'package:fav_movies/core/common/responses/status/response_status.dart';
import 'package:fav_movies/modules/details/domain/i_repositories/i_review_movie_repository.dart';
import 'package:fav_movies/modules/details/domain/models/movie_review.dart';
import 'package:sqflite/sqflite.dart';

part 'review_movie_model.dart';


class ReviewMovieRepository implements IReviewMovieRepository {
  final Database _database;

  ReviewMovieRepository(this._database);

  @override
  Future<ResponseStatus> saveReview(MovieReview review) async {
    final response = await _database.insert('ReviewMovies', review.toTableModel(), conflictAlgorithm: ConflictAlgorithm.replace);

    return ResponseStatus(code: response, message: 'ok');
  }
}

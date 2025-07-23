import 'package:my_movie_repository/src/entities/my_movie.dart';

abstract class MyMovieRepository {
  Future<MyMovie> addFavoriteMovie(String userId, MyMovie myMovie);
  Future<void> deleteFavoriteMovie(String userId, String movieId);
  Future<MyMovie> addHistory(String userId, MyMovie myMovie);
  Future<List<MyMovie>> getFavorites(String userId);
  Future<List<MyMovie>> getHistory(String userId);
  Future<bool> isFavorite(String userId, String movieId);
}

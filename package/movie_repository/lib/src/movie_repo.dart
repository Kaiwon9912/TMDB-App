import 'package:movie_repository/movie_repository.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getTrendingMovieDay();
  Future<List<MovieEntity>> getTrendingMovieWeek();
  Future<List<MovieEntity>> getPopularMovie();
  Future<List<MovieEntity>> getTopRatedMovie();
  Future<List<MovieEntity>> getNowPlayingMovie();
  Future<MovieEntity> getMovieDetail(String id);
  Future<List<MovieEntity>> getRecommendations(String movieID);
  Future<List<MovieEntity>> searchMovies(String query);
  Future<PeopleEntity> getPeopleDetail(String id);
  Future<List<PeopleEntity>> getMovieCredits(String id);
  Future<List<MovieEntity>> getPeopleCredits(String id);
}

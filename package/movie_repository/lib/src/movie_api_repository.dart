import 'package:movie_repository/src/data/apiService.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:movie_repository/src/models/peopleModel.dart';

class MovieApiRepository implements MovieRepository {
  @override
  Future<MovieEntity> getMovieDetail(String id) async {
    final rawDetail = await ApiService.fetchMovieDetail(id);
    return MovieModel.fromJson(rawDetail).toEntity();
  }

  @override
  Future<List<MovieEntity>> getRecommendations(String movieID) async {
    final rawData = await ApiService.fetchRecommendations(movieID);
    return MovieModel.toEntityList(rawData);
  }

  @override
  Future<List<MovieEntity>> searchMovies(String query) async {
    final rawData = await ApiService.searchMovies(query);
    return MovieModel.toEntityList(rawData['results']);
  }

  @override
  Future<List<MovieEntity>> getPeopleCredits(String id) async {
    final rawData = await ApiService.fetchPeopleCredits(int.parse(id));
    return MovieModel.toEntityList(rawData);
  }

  @override
  Future<List<MovieEntity>> getNowPlayingMovie() async {
    final rawMovies = await ApiService.fetchMovies('/movie/now_playing');
    return MovieModel.toEntityList(rawMovies);
  }

  @override
  Future<List<MovieEntity>> getPopularMovie() async {
    final rawMovies = await ApiService.fetchMovies('/movie/popular');
    return MovieModel.toEntityList(rawMovies);
  }

  @override
  Future<List<MovieEntity>> getTopRatedMovie() async {
    final rawMovies = await ApiService.fetchMovies('/movie/top_rated');
    return MovieModel.toEntityList(rawMovies);
  }

  @override
  Future<List<MovieEntity>> getTrendingMovieWeek() async {
    final rawMovies = await ApiService.fetchMovies('/trending/movie/week');
    return MovieModel.toEntityList(rawMovies);
  }

  @override
  Future<List<MovieEntity>> getTrendingMovieDay() async {
    final rawMovies = await ApiService.fetchMovies('/trending/movie/day');
    return MovieModel.toEntityList(rawMovies);
  }

  @override
  Future<List<PeopleEntity>> getMovieCredits(String id) async {
    final rawData = await ApiService.fetchMovieCredits(id);
    return PeopleModel.toEntityList(rawData);
  }

  @override
  Future<PeopleEntity> getPeopleDetail(String id) async {
    final rawData = await ApiService.fetchPeopleDetail(id);
    return PeopleModel.fromJson(rawData).toEntity();
  }
}

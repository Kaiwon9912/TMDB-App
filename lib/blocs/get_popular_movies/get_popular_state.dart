part of 'get_popular_bloc.dart';

sealed class GetPopularState extends Equatable {
  const GetPopularState();

  @override
  List<Object> get props => [];
}

final class GetPopularInitial extends GetPopularState {}

final class GetPopularMovieLoading extends GetPopularState {}

final class GetPopularMovieSuccess extends GetPopularState {
  final List<MovieEntity> movies;
  const GetPopularMovieSuccess(this.movies);
}

final class GetPopularMovieFailed extends GetPopularState {
  final String error;
  const GetPopularMovieFailed(this.error);
}

part of 'get_top_rated_bloc.dart';

sealed class GetTopRatedState extends Equatable {
  const GetTopRatedState();

  @override
  List<Object> get props => [];
}

final class GetTopRatedInitial extends GetTopRatedState {}

final class GetTopRatedMovieSucess extends GetTopRatedState {
  final List<MovieEntity> movies;
  const GetTopRatedMovieSucess(this.movies);
}

final class GetTopRatedMovieFailed extends GetTopRatedState {
  final String error;
  const GetTopRatedMovieFailed(this.error);
}

final class GetTopRatedMovieLoading extends GetTopRatedState {}

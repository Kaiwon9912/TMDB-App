part of 'get_trending_day_bloc.dart';

sealed class GetTrendingDayState extends Equatable {
  const GetTrendingDayState();

  @override
  List<Object> get props => [];
}

final class GetTrendingDayInitial extends GetTrendingDayState {}

final class GetTrendingMovieSuccess extends GetTrendingDayState {
  final List<MovieEntity> movies;
  const GetTrendingMovieSuccess(this.movies);
}

final class GetTrendingMovieFailed extends GetTrendingDayState {
  final String error;
  const GetTrendingMovieFailed(this.error);
}

final class GetTrendingMovieLoading extends GetTrendingDayState {}

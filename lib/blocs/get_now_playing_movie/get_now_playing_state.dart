part of 'get_now_playing_bloc.dart';

sealed class GetNowPlayingState extends Equatable {
  const GetNowPlayingState();

  @override
  List<Object> get props => [];
}

final class GetNowPlayingInitial extends GetNowPlayingState {}

final class GetNowPlayingMovieSuccess extends GetNowPlayingState {
  final List<MovieEntity> movies;
  const GetNowPlayingMovieSuccess(this.movies);
  @override
  // TODO: implement props
  List<Object> get props => [movies];
}

final class GetNowPlayingMovieLoading extends GetNowPlayingState {}

final class GetNowPlayingMovieFailed extends GetNowPlayingState {
  final String err;
  const GetNowPlayingMovieFailed(this.err);
}

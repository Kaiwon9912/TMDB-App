part of 'get_movie_detail_bloc.dart';

sealed class GetMovieDetailState extends Equatable {
  const GetMovieDetailState();

  @override
  List<Object> get props => [];
}

final class GetMovieDetailInitial extends GetMovieDetailState {}

final class GetMovieSuccess extends GetMovieDetailState {
  final MovieEntity movie;
  const GetMovieSuccess(this.movie);
}

final class GetMovieFailed extends GetMovieDetailState {}

final class GetMovieLoading extends GetMovieDetailState {}

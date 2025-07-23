part of 'get_movie_credits_bloc.dart';

sealed class GetMovieCreditsState extends Equatable {
  const GetMovieCreditsState();

  @override
  List<Object> get props => [];
}

final class GetMovieCreditsInitial extends GetMovieCreditsState {}

final class GetMovieCreditsLoading extends GetMovieCreditsState {}

final class GetMovieCreditsSuccess extends GetMovieCreditsState {
  final List<PeopleEntity> actors;
  const GetMovieCreditsSuccess(this.actors);
}

final class GetMovieCreditsFailed extends GetMovieCreditsState {}

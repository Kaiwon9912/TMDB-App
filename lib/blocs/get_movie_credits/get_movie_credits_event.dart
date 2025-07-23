part of 'get_movie_credits_bloc.dart';

sealed class GetMovieCreditsEvent extends Equatable {
  const GetMovieCreditsEvent();

  @override
  List<Object> get props => [];
}

class GetMovieCredits extends GetMovieCreditsEvent {
  final String movieId;
  const GetMovieCredits(this.movieId);
}

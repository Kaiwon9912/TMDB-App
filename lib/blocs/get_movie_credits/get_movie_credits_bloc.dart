import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:movie_repository/movie_repository.dart';

part 'get_movie_credits_event.dart';
part 'get_movie_credits_state.dart';

class GetMovieCreditsBloc
    extends Bloc<GetMovieCreditsEvent, GetMovieCreditsState> {
  final MovieRepository _movieRepository;
  GetMovieCreditsBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(GetMovieCreditsInitial()) {
    on<GetMovieCredits>((event, emit) async {
      emit(GetMovieCreditsLoading());
      try {
        List<PeopleEntity> actors = await _movieRepository.getMovieCredits(
          event.movieId,
        );
        emit(GetMovieCreditsSuccess(actors));
      } catch (e) {
        emit(GetMovieCreditsFailed());
      }
    });
  }
}

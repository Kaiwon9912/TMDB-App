import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:movie_library/boxes.dart';
import 'package:movie_repository/movie_repository.dart';

part 'get_top_rated_event.dart';
part 'get_top_rated_state.dart';

class GetTopRatedBloc extends Bloc<GetTopRatedEvent, GetTopRatedState> {
  final MovieRepository _movieRepository;

  GetTopRatedBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(GetTopRatedInitial()) {
    on<GetTopRatedMovie>((event, emit) async {
      final cached = boxTopRatedMovies.values.whereType<MovieEntity>().toList();
      if (cached.isNotEmpty) {
        emit(GetTopRatedMovieSucess(cached));
      } else {
        emit(GetTopRatedMovieLoading());
      }
      try {
        List<MovieEntity> movies = await _movieRepository.getTopRatedMovie();
        emit(GetTopRatedMovieSucess(movies));
      } catch (e) {
        emit(GetTopRatedMovieFailed(e.toString()));
      }
    });
  }
}

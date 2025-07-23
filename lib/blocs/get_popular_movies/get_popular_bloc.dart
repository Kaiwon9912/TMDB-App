import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:movie_library/boxes.dart';

import 'package:movie_repository/movie_repository.dart';

part 'get_popular_event.dart';
part 'get_popular_state.dart';

class GetPopularBloc extends Bloc<GetPopularEvent, GetPopularState> {
  final MovieRepository _movieRepository;

  GetPopularBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(GetPopularInitial()) {
    on<GetPopularMovie>((event, emit) async {
      final cached = boxPopularMovies.values.whereType<MovieEntity>().toList();
      if (cached.isNotEmpty) {
        emit(GetPopularMovieSuccess(cached));
      } else {
        emit(GetPopularMovieLoading());
      }
      try {
        List<MovieEntity> movies = await _movieRepository.getPopularMovie();
        await boxPopularMovies.clear();
        for (var movie in movies) {
          await boxPopularMovies.put(movie.id, movie);
        }
        emit(GetPopularMovieSuccess(movies));
      } catch (e) {
        emit(GetPopularMovieFailed(e.toString()));
      }
    });
  }
}

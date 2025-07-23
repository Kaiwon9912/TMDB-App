import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_library/boxes.dart';
import 'package:movie_repository/movie_repository.dart';

part 'get_now_playing_event.dart';
part 'get_now_playing_state.dart';

class GetNowPlayingBloc extends Bloc<GetNowPlayingEvent, GetNowPlayingState> {
  final MovieRepository _movieRepository;
  GetNowPlayingBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(GetNowPlayingInitial()) {
    on<GetNowPlayingMovie>((event, emit) async {
      final cached = boxNowPlayingMovies.values
          .whereType<MovieEntity>()
          .toList();
      if (cached.isNotEmpty) {
        emit(GetNowPlayingMovieSuccess(cached));
      } else {
        emit(GetNowPlayingMovieLoading());
      }
      final box = Hive.box<MovieEntity>('nowPlayingMovies');
      try {
        List<MovieEntity> movies = await _movieRepository.getNowPlayingMovie();
        await box.clear();
        for (var movie in movies) {
          await box.put(movie.id, movie);
        }
        emit(GetNowPlayingMovieSuccess(movies));
      } catch (e) {
        emit(GetNowPlayingMovieFailed(e.toString()));
      }
    });
  }
}

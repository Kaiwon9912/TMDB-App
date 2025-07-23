import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:movie_library/boxes.dart';
import 'package:movie_repository/movie_repository.dart';

part 'get_trending_day_event.dart';
part 'get_trending_day_state.dart';

class GetTrendingDayBloc
    extends Bloc<GetTrendingDayEvent, GetTrendingDayState> {
  final MovieRepository _movieRepository;
  GetTrendingDayBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(GetTrendingDayInitial()) {
    on<GetTrendingMovie>((event, emit) async {
      final cached = boxPopularMovies.values.whereType<MovieEntity>().toList();
      if (cached.isNotEmpty) {
        emit(GetTrendingMovieSuccess(cached));
      } else {
        emit(GetTrendingMovieLoading());
      }
      try {
        List<MovieEntity> movies = await _movieRepository.getTrendingMovieDay();
        emit(GetTrendingMovieSuccess(movies));
      } catch (e) {
        emit(GetTrendingMovieFailed(e.toString()));
      }
    });
  }
}

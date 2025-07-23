import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';

part 'get_movie_detail_event.dart';
part 'get_movie_detail_state.dart';

class GetMovieDetailBloc
    extends Bloc<GetMovieDetailEvent, GetMovieDetailState> {
  final MovieRepository _movieRepository;
  GetMovieDetailBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(GetMovieDetailInitial()) {
    on<GetMovieDetail>((event, emit) async {
      emit(GetMovieLoading());
      try {
        MovieEntity movie = await _movieRepository.getMovieDetail(event.id);
        emit(GetMovieSuccess(movie));
      } catch (e) {
        emit(GetMovieFailed());
      }
    });
  }
}

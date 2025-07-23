import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_repository/movie_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository _movieRepository;
  SearchBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(SearchInitial()) {
    on<Search>((event, emit) async {
      emit(SearchLoading());
      try {
        final movies = await _movieRepository.searchMovies(event.query);
        emit(SearchSuccess(movies));
      } catch (e) {
        emit(SearchFailure());
      }
    });
  }
}

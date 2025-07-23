import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_movie_repository/my_movie_repsitory.dart';

part 'get_favorites_event.dart';
part 'get_favorites_state.dart';

class GetFavoritesBloc extends Bloc<GetFavoritesEvent, GetFavoritesState> {
  final MyMovieRepository _myMovieRepository;
  GetFavoritesBloc({required MyMovieRepository myMovieRepoistory})
    : _myMovieRepository = myMovieRepoistory,
      super(GetFavoritesInitial()) {
    on<GetFavorites>((event, emit) async {
      emit(GetFavoritesLoading());
      try {
        final movies = await _myMovieRepository.getFavorites(event.userId);
        emit(GetFavoritesSuccess(movies));
      } catch (e) {
        emit(GetFavoritesFailed());
      }
    });
  }
}

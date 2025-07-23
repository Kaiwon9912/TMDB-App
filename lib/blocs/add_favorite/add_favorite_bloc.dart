import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_movie_repository/my_movie_repsitory.dart';

part 'add_favorite_event.dart';
part 'add_favorite_state.dart';

class AddFavoriteBloc extends Bloc<AddFavoriteEvent, AddFavoriteState> {
  final MyMovieRepository _myMovieRepository;
  AddFavoriteBloc({required MyMovieRepository myMovieRepository})
    : _myMovieRepository = myMovieRepository,
      super(AddFavoriteInitial()) {
    on<AddFavorite>((event, emit) async {
      emit(AddFavoritesLoading());
      try {
        _myMovieRepository.addFavoriteMovie(event.userId, event.myMovie);
        emit(AddFavoritesSuccess());
      } catch (e) {
        emit(AddFavoritesFailed(e.toString()));
      }
    });
  }
}

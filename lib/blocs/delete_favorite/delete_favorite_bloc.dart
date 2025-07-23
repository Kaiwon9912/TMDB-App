import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_movie_repository/my_movie_repsitory.dart';

part 'delete_favorite_event.dart';
part 'delete_favorite_state.dart';

class DeleteFavoriteBloc
    extends Bloc<DeleteFavoriteEvent, DeleteFavoriteState> {
  final MyMovieRepository _myMovieRepository;
  DeleteFavoriteBloc({required MyMovieRepository myMovieRepository})
    : _myMovieRepository = myMovieRepository,
      super(DeleteFavoriteInitial()) {
    on<DeleteFavorite>((event, emit) {
      emit(DeleteFavoriteLoading());
      try {
        _myMovieRepository.deleteFavoriteMovie(event.userId, event.movieId);
      } catch (e) {
        emit(DeleteFavoriteFailed());
      }
    });
  }
}

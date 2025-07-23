import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:my_movie_repository/my_movie_repsitory.dart';

part 'get_history_event.dart';
part 'get_history_state.dart';

class GetHistoryBloc extends Bloc<GetHistoryEvent, GetHistoryState> {
  final MyMovieRepository _myMovieRepository;
  GetHistoryBloc({required MyMovieRepository myMovieRepository})
    : _myMovieRepository = myMovieRepository,
      super(GetHistoryInitial()) {
    on<GetHistory>((event, emit) async {
      emit(GetHistoryLoading());
      try {
        final movies = await _myMovieRepository.getHistory(event.userId);
        emit(GetHistorySuccess(movies));
      } catch (e) {
        emit(GetHistoryFailed());
      }
    });
  }
}

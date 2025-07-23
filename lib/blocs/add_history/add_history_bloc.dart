import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/physics.dart';
import 'package:my_movie_repository/my_movie_repsitory.dart';

part 'add_history_event.dart';
part 'add_history_state.dart';

class AddHistoryBloc extends Bloc<AddHistoryEvent, AddHistoryState> {
  final MyMovieRepository _myMovieRepository;
  AddHistoryBloc({required MyMovieRepository myMovieRepository})
    : _myMovieRepository = myMovieRepository,
      super(AddHistoryInitial()) {
    on<AddHistory>((event, emit) async {
      emit(AddHistoryLoading());
      try {
        _myMovieRepository.addHistory(event.userId, event.myMovie);
        emit(AddHistorySuccess());
      } catch (e) {
        emit(AddHistoryFailed(e.toString()));
      }
    });
  }
}

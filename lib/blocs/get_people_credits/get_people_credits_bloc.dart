import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_repository/movie_repository.dart';

part 'get_people_credits_event.dart';
part 'get_people_credits_state.dart';

class GetPeopleCreditsBloc
    extends Bloc<GetPeopleCreditsEvent, GetPeopleCreditsState> {
  final MovieRepository _movieRepository;
  GetPeopleCreditsBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(GetPeopleCreditsInitial()) {
    on<GetPeopleCredits>((event, emit) async {
      emit(GetPeopleCreditsLoading());
      try {
        final movies = await _movieRepository.getPeopleCredits(event.id);
        emit(GetPeopleCreditsSuccess(movies));
      } catch (e) {
        emit(GetPeopleCreditsFailed(e.toString()));
      }
    });
  }
}

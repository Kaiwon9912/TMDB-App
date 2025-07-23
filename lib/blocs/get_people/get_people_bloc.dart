import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_repository/movie_repository.dart';

part 'get_people_event.dart';
part 'get_people_state.dart';

class GetPeopleBloc extends Bloc<GetPeopleEvent, GetPeopleState> {
  final MovieRepository _movieRepository;
  GetPeopleBloc({required MovieRepository movieReposiotry})
    : _movieRepository = movieReposiotry,
      super(GetPeopleInitial()) {
    on<GetPeople>((event, emit) async {
      emit(GetPeopleLoading());
      try {
        final actor = await _movieRepository.getPeopleDetail(event.actorId);
        emit(GetPeopleSuccess(actor));
      } catch (e) {
        emit(GetPeopleFailed());
      }
    });
  }
}

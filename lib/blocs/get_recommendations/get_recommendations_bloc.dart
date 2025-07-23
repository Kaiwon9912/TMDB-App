import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_repository/movie_repository.dart';

part 'get_recommendations_event.dart';
part 'get_recommendations_state.dart';

class GetRecommendationsBloc
    extends Bloc<GetRecommendationsEvent, GetRecommendationsState> {
  final MovieRepository _movieRepository;
  GetRecommendationsBloc({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(GetRecommendationsInitial()) {
    on<GetRecommendations>((event, emit) async {
      emit(GetRecommendatationsLoading());
      try {
        List<MovieEntity> movies = await _movieRepository.getRecommendations(
          event.movieId,
        );
        emit(GetRecommendatationsSuccess(movies));
      } catch (e) {
        emit(GetRecommendationsFailed());
      }
    });
  }
}

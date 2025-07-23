part of 'get_recommendations_bloc.dart';

sealed class GetRecommendationsEvent extends Equatable {
  const GetRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendations extends GetRecommendationsEvent {
  final String movieId;
  const GetRecommendations(this.movieId);
}

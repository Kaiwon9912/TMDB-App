part of 'get_recommendations_bloc.dart';

sealed class GetRecommendationsState extends Equatable {
  const GetRecommendationsState();

  @override
  List<Object> get props => [];
}

final class GetRecommendationsInitial extends GetRecommendationsState {}

final class GetRecommendatationsLoading extends GetRecommendationsState {}

final class GetRecommendatationsSuccess extends GetRecommendationsState {
  final List<MovieEntity> movies;
  const GetRecommendatationsSuccess(this.movies);
}

final class GetRecommendationsFailed extends GetRecommendationsState {}

part of 'get_people_credits_bloc.dart';

sealed class GetPeopleCreditsState extends Equatable {
  const GetPeopleCreditsState();

  @override
  List<Object> get props => [];
}

final class GetPeopleCreditsInitial extends GetPeopleCreditsState {}

final class GetPeopleCreditsLoading extends GetPeopleCreditsState {}

final class GetPeopleCreditsFailed extends GetPeopleCreditsState {
  final String err;
  const GetPeopleCreditsFailed(this.err);
}

final class GetPeopleCreditsSuccess extends GetPeopleCreditsState {
  final List<MovieEntity> movies;
  const GetPeopleCreditsSuccess(this.movies);
}

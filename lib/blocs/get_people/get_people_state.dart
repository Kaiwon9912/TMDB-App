part of 'get_people_bloc.dart';

sealed class GetPeopleState extends Equatable {
  const GetPeopleState();

  @override
  List<Object> get props => [];
}

final class GetPeopleInitial extends GetPeopleState {}

final class GetPeopleLoading extends GetPeopleState {}

final class GetPeopleFailed extends GetPeopleState {}

final class GetPeopleSuccess extends GetPeopleState {
  final PeopleEntity actor;
  const GetPeopleSuccess(this.actor);
}

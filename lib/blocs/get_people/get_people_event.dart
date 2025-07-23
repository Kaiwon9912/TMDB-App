part of 'get_people_bloc.dart';

sealed class GetPeopleEvent extends Equatable {
  const GetPeopleEvent();

  @override
  List<Object> get props => [];
}

final class GetPeople extends GetPeopleEvent {
  final String actorId;
  const GetPeople(this.actorId);
}

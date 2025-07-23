part of 'get_people_credits_bloc.dart';

sealed class GetPeopleCreditsEvent extends Equatable {
  const GetPeopleCreditsEvent();

  @override
  List<Object> get props => [];
}

class GetPeopleCredits extends GetPeopleCreditsEvent {
  final String id;
  const GetPeopleCredits(this.id);
}

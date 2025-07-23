part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetMyUser extends UserEvent {
  final String userId;
  const GetMyUser({required this.userId});

  @override
  // TODO: implement props
  List<Object> get props => [userId];
}

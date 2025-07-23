part of 'add_history_bloc.dart';

sealed class AddHistoryEvent extends Equatable {
  const AddHistoryEvent();

  @override
  List<Object> get props => [];
}

class AddHistory extends AddHistoryEvent {
  final String userId;
  final MyMovie myMovie;
  const AddHistory(this.userId, this.myMovie);
}

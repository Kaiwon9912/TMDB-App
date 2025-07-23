part of 'get_history_bloc.dart';

sealed class GetHistoryEvent extends Equatable {
  const GetHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetHistory extends GetHistoryEvent {
  final String userId;
  const GetHistory(this.userId);
}

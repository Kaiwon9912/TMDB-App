part of 'add_history_bloc.dart';

sealed class AddHistoryState extends Equatable {
  const AddHistoryState();

  @override
  List<Object> get props => [];
}

final class AddHistoryInitial extends AddHistoryState {}

final class AddHistoryLoading extends AddHistoryState {}

final class AddHistoryFailed extends AddHistoryState {
  final String err;
  const AddHistoryFailed(this.err);
}

final class AddHistorySuccess extends AddHistoryState {}

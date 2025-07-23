part of 'get_history_bloc.dart';

sealed class GetHistoryState extends Equatable {
  const GetHistoryState();

  @override
  List<Object> get props => [];
}

final class GetHistoryInitial extends GetHistoryState {}

final class GetHistoryLoading extends GetHistoryState {}

final class GetHistoryFailed extends GetHistoryState {}

final class GetHistorySuccess extends GetHistoryState {
  final List<MyMovie> movies;
  const GetHistorySuccess(this.movies);
}

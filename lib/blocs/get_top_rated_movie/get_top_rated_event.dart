part of 'get_top_rated_bloc.dart';

sealed class GetTopRatedEvent extends Equatable {
  const GetTopRatedEvent();

  @override
  List<Object> get props => [];
}

final class GetTopRatedMovie extends GetTopRatedEvent {}

part of 'get_trending_day_bloc.dart';

sealed class GetTrendingDayEvent extends Equatable {
  const GetTrendingDayEvent();

  @override
  List<Object> get props => [];
}

class GetTrendingMovie extends GetTrendingDayEvent {}

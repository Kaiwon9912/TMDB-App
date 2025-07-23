part of 'get_now_playing_bloc.dart';

sealed class GetNowPlayingEvent extends Equatable {
  const GetNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMovie extends GetNowPlayingEvent {}

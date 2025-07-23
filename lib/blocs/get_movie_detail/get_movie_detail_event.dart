part of 'get_movie_detail_bloc.dart';

sealed class GetMovieDetailEvent extends Equatable {
  const GetMovieDetailEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetail extends GetMovieDetailEvent {
  final String id;
  const GetMovieDetail(this.id);
}

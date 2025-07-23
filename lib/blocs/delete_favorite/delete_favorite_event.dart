part of 'delete_favorite_bloc.dart';

sealed class DeleteFavoriteEvent extends Equatable {
  const DeleteFavoriteEvent();

  @override
  List<Object> get props => [];
}

class DeleteFavorite extends DeleteFavoriteEvent {
  final String userId;
  final String movieId;
  const DeleteFavorite(this.userId, this.movieId);
}

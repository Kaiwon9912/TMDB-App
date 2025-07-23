part of 'add_favorite_bloc.dart';

sealed class AddFavoriteEvent extends Equatable {
  const AddFavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavorite extends AddFavoriteEvent {
  final MyMovie myMovie;
  final String userId;
  const AddFavorite(this.userId, this.myMovie);
}

part of 'add_favorite_bloc.dart';

sealed class AddFavoriteState extends Equatable {
  const AddFavoriteState();

  @override
  List<Object> get props => [];
}

final class AddFavoriteInitial extends AddFavoriteState {}

final class AddFavoritesLoading extends AddFavoriteState {}

final class AddFavoritesFailed extends AddFavoriteState {
  final String err;
  const AddFavoritesFailed(this.err);
}

final class AddFavoritesSuccess extends AddFavoriteState {}

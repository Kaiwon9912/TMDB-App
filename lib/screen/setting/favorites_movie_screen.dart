import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_library/blocs/get_favorites/get_favorites_bloc.dart';
import 'package:movie_library/blocs/user/user_bloc.dart';
import 'package:movie_library/components/movieCard.dart';
import 'package:movie_repository/movie_repository.dart';

class FavoritesMovieScreen extends StatefulWidget {
  final String userId;
  const FavoritesMovieScreen({super.key, required this.userId});

  @override
  State<FavoritesMovieScreen> createState() => _FavoritesMovieScreenState();
}

class _FavoritesMovieScreenState extends State<FavoritesMovieScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetFavoritesBloc>().add(GetFavorites(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetFavoritesBloc, GetFavoritesState>(
        builder: (context, state) {
          if (state is GetFavoritesSuccess) {
            final movies = state.movies;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 2 cột
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final movieEntity = MovieEntity.empty.copyWith(
                    id: movie.id,
                    posterPath: movie.posterPath,
                    title: movie.title,
                  );
                  return MovieCard(movie: movieEntity);
                },
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

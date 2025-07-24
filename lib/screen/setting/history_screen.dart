import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_library/blocs/get_history/get_history_bloc.dart';
import 'package:movie_library/components/movieCard.dart';
import 'package:movie_repository/movie_repository.dart';

class HistoryScreen extends StatefulWidget {
  final String userId;
  const HistoryScreen({super.key, required this.userId});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetHistoryBloc>().add(GetHistory(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHistoryBloc, GetHistoryState>(
      builder: (context, state) {
        if (state is GetHistorySuccess) {
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
                  voteAverage: movie.voteAverage,
                );
                return MovieCard(movie: movieEntity);
              },
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

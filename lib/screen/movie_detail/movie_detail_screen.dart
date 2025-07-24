import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_library/blocs/add_favorite/add_favorite_bloc.dart';
import 'package:movie_library/blocs/add_history/add_history_bloc.dart';
import 'package:movie_library/blocs/authentication/authentication_bloc.dart';
import 'package:movie_library/blocs/get_movie_credits/get_movie_credits_bloc.dart';
import 'package:movie_library/blocs/get_movie_detail/get_movie_detail_bloc.dart';
import 'package:movie_library/blocs/get_recommendations/get_recommendations_bloc.dart';

import 'package:movie_repository/movie_repository.dart';
import 'package:my_movie_repository/my_movie_repsitory.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieID});

  final String movieID;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetMovieDetailBloc>().add(GetMovieDetail(widget.movieID));
    context.read<GetMovieCreditsBloc>().add(GetMovieCredits(widget.movieID));

    context.read<GetRecommendationsBloc>().add(
      GetRecommendations(widget.movieID),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<GetMovieDetailBloc, GetMovieDetailState>(
        builder: (context, state) {
          if (state is GetMovieSuccess) {
            final movie = state.movie;
            final myMovie = MyMovie.empty.copyWith(
              title: movie.title,
              posterPath: movie.posterPath,
              id: movie.id,
              voteAverage: movie.voteAverage,
            );

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                state.movie.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                SizedBox(width: 5),
                                Text(
                                  state.movie.voteAverage.toStringAsFixed(1),

                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8,
                      children: (movie.genres!)
                          .map(
                            (genre) => Chip(
                              label: Text(genre),
                              backgroundColor: Colors.grey[800],
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state.status == AuthenticationStatus.authenticated) {
                        final userId = context
                            .read<AuthenticationBloc>()
                            .state
                            .user!
                            .uid;
                        context.read<AddHistoryBloc>().add(
                          AddHistory(userId, myMovie),
                        );
                        return BlocListener<AddFavoriteBloc, AddFavoriteState>(
                          listener: (context, state) {
                            if (state is AddFavoritesSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Saved to Favorites'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (state is AddFavoritesFailed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    state.err,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {}
                          },
                          child: GestureDetector(
                            onTap: () {
                              context.read<AddFavoriteBloc>().add(
                                AddFavorite(userId, myMovie),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Center(child: Text('Add to Favorites ')),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(movie.overview),
                  ),
                  BlocBuilder<GetMovieCreditsBloc, GetMovieCreditsState>(
                    builder: (context, state) {
                      if (state is GetMovieCreditsSuccess) {
                        return _buildCredits(state.actors);
                      } else {
                        return SizedBox(
                          height: 190,
                          child: Lottie.asset('assets/lottie/loading.json'),
                        );
                      }
                    },
                  ),
                  BlocBuilder<GetRecommendationsBloc, GetRecommendationsState>(
                    builder: (context, state) {
                      if (state is GetRecommendatationsSuccess) {
                        return _buildRecommendatations(state.movies);
                      } else {
                        return Lottie.asset('assets/lottie/loading.json');
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Lottie.asset('assets/lottie/loading.json'));
          }
        },
      ),
    );
  }

  _buildCredits(actors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Cast',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: actors.length,
            itemBuilder: (context, index) {
              final actor = actors[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    context.push('/actor/${actor.id}');
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: actor.profilePath != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w200${actor.profilePath}',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/unknown.png',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Text(
                          actor.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          actor.character ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildRecommendatations(List<MovieEntity> listMovie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommendations',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 300,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listMovie.length,
            itemBuilder: (context, index) {
              final movie = listMovie[index];
              return Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    context.push('/movie/${movie.id}');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w300${movie.backdropPath}',
                              width: 300,
                            ),
                          ),

                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  Text(movie.voteAverage.toStringAsFixed(1)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 300,
                        child: Text(movie.title, textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

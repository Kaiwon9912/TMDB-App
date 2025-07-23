import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_library/blocs/get_now_playing_movie/get_now_playing_bloc.dart';
import 'package:movie_library/blocs/get_popular_movies/get_popular_bloc.dart';
import 'package:movie_library/blocs/get_top_rated_movie/get_top_rated_bloc.dart';
import 'package:movie_library/blocs/get_trending_day/get_trending_day_bloc.dart';
import 'package:movie_library/components/movieCard.dart';

import 'package:movie_repository/movie_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refeshMovies() async {
    context.read<GetNowPlayingBloc>().add(GetNowPlayingMovie());
    context.read<GetTrendingDayBloc>().add(GetTrendingMovie());
    context.read<GetPopularBloc>().add(GetPopularMovie());
    context.read<GetTopRatedBloc>().add(GetTopRatedMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'C',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'nema',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],

        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: RefreshIndicator(
        onRefresh: _refeshMovies,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<GetNowPlayingBloc, GetNowPlayingState>(
                builder: (context, state) {
                  if (state is GetNowPlayingMovieSuccess) {
                    return _builCarousel(state.movies);
                  }
                  if (state is GetNowPlayingMovieFailed) {
                    return Center(child: Text(state.err));
                  } else {
                    return Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.grey),
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Trending',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              BlocBuilder<GetTrendingDayBloc, GetTrendingDayState>(
                builder: (context, state) {
                  if (state is GetTrendingMovieSuccess) {
                    return _buildSection(state.movies);
                  } else {
                    return SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Popular',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              BlocBuilder<GetPopularBloc, GetPopularState>(
                builder: (context, state) {
                  if (state is GetPopularMovieSuccess) {
                    return _buildSection(state.movies);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Top Rated',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              BlocBuilder<GetTopRatedBloc, GetTopRatedState>(
                builder: (context, state) {
                  if (state is GetTopRatedMovieSucess) {
                    return _buildSection(state.movies);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildSection(List<MovieEntity> movies) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var movie = movies[index];
          return MovieCard(movie: movie);
        },
      ),
    );
  }

  _builCarousel(List<MovieEntity> movies) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 350,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1,
      ),
      items: movies.map((movie) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 63,
              left: 10,
              child: Column(
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Text(
                    movie.overview.length > 90
                        ? '${movie.overview.substring(0, 90)}...'
                        : movie.overview,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

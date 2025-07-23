import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_library/blocs/get_people/get_people_bloc.dart';
import 'package:movie_library/blocs/get_people_credits/get_people_credits_bloc.dart';
import 'package:movie_library/components/movieCard.dart';
import 'package:movie_library/components/readmore.dart';
import 'package:movie_repository/movie_repository.dart';

class PeopleDetailScreen extends StatefulWidget {
  const PeopleDetailScreen({super.key, required this.actorId});
  final String actorId;

  @override
  State<PeopleDetailScreen> createState() => _PeopleDetailScreenState();
}

class _PeopleDetailScreenState extends State<PeopleDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<GetPeopleBloc>().add(GetPeople(widget.actorId));
    context.read<GetPeopleCreditsBloc>().add(GetPeopleCredits(widget.actorId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<GetPeopleBloc, GetPeopleState>(
        builder: (context, state) {
          if (state is GetPeopleSuccess) {
            final actor = state.actor;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        actor.profilePath != null
                            ? Image.network(
                                width: 120,
                                'https://image.tmdb.org/t/p/w300${actor.profilePath}',
                              )
                            : Image.asset('/assets/unknown.jpg'),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                actor.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text('Birthday: ${actor.birthday}'),
                              SizedBox(height: 8),
                              Text(
                                'Born: ${actor.placeOfBirth}',
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Biography',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    actor.biography != null
                        ? ReadMoreText(text: actor.biography!, length: 500)
                        : Text('No bio'),
                    const SizedBox(height: 8),
                    const Text(
                      'Known for',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<GetPeopleCreditsBloc, GetPeopleCreditsState>(
                      builder: (context, state) {
                        if (state is GetPeopleCreditsSuccess) {
                          final movies = state.movies;
                          return SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: movies.length,
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                return MovieCard(movie: movie);
                              },
                            ),
                          );
                        } else if (state is GetPeopleCreditsFailed) {
                          return Center(child: Text(state.err));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
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

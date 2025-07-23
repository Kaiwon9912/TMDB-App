import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_library/app_view.dart';

import 'package:movie_library/blocs/authentication/authentication_bloc.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:my_movie_repository/my_movie_repsitory.dart';
import 'package:user_repository/user_repository.dart';

class MainApp extends StatelessWidget {
  final UserRepository userRepository;
  const MainApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>.value(value: userRepository),
        RepositoryProvider<MovieRepository>(
          create: (_) => MovieApiRepository(),
        ),
        RepositoryProvider<MyMovieRepository>(
          create: (_) => FirebaseMovieRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          myUserRepository: context.read<UserRepository>(),
        ),
        child: const MyAppView(),
      ),
    );
  }
}

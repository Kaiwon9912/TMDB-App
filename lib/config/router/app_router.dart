import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_library/blocs/add_favorite/add_favorite_bloc.dart';
import 'package:movie_library/blocs/add_history/add_history_bloc.dart';
import 'package:movie_library/blocs/authentication/authentication_bloc.dart';
import 'package:movie_library/blocs/get_favorites/get_favorites_bloc.dart';
import 'package:movie_library/blocs/get_movie_credits/get_movie_credits_bloc.dart';
import 'package:movie_library/blocs/get_movie_detail/get_movie_detail_bloc.dart';
import 'package:movie_library/blocs/get_now_playing_movie/get_now_playing_bloc.dart';
import 'package:movie_library/blocs/get_people/get_people_bloc.dart';
import 'package:movie_library/blocs/get_people_credits/get_people_credits_bloc.dart';
import 'package:movie_library/blocs/get_popular_movies/get_popular_bloc.dart';
import 'package:movie_library/blocs/get_recommendations/get_recommendations_bloc.dart';
import 'package:movie_library/blocs/get_top_rated_movie/get_top_rated_bloc.dart';
import 'package:movie_library/blocs/get_trending_day/get_trending_day_bloc.dart';
import 'package:movie_library/blocs/search/search_bloc.dart';
import 'package:movie_library/blocs/sign_in/sign_in_bloc.dart';
import 'package:movie_library/blocs/update_user_info_bloc/update_user_info_bloc.dart';

import 'package:movie_library/blocs/user/user_bloc.dart';

import 'package:movie_library/config/router/routes.dart';

import 'package:movie_library/layout/layout_scaffold.dart';
import 'package:movie_library/screen/authentication/authentication_screen.dart';

import 'package:movie_library/screen/home/home_screen.dart';
import 'package:movie_library/screen/movie_detail/movie_detail_screen.dart';
import 'package:movie_library/screen/people_detail/people_detail_screen.dart';

import 'package:movie_library/screen/search/search_screen.dart';
import 'package:movie_library/screen/setting/my_movie_screen.dart';
import 'package:movie_library/screen/setting/setting_screen.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:my_movie_repository/my_movie_repsitory.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
GoRouter createRouter(AuthenticationBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,

    initialLocation: '/home',

    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthenticationScreen(),
      ),
      GoRoute(
        path: Routes.actorDetail,
        builder: (context, state) {
          final actorId = state.pathParameters['actorId'];
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => GetPeopleBloc(
                  movieReposiotry: context.read<MovieRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => GetPeopleCreditsBloc(
                  movieRepository: context.read<MovieRepository>(),
                ),
              ),
            ],
            child: PeopleDetailScreen(actorId: actorId!),
          );
        },
      ),
      GoRoute(
        path: Routes.movieDetail,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final movieId = state.pathParameters['movieId'];
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => GetMovieDetailBloc(
                  movieRepository: context.read<MovieRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => GetMovieCreditsBloc(
                  movieRepository: context.read<MovieRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => GetRecommendationsBloc(
                  movieRepository: context.read<MovieRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => AddFavoriteBloc(
                  myMovieRepository: context.read<MyMovieRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => AddHistoryBloc(
                  myMovieRepository: context.read<MyMovieRepository>(),
                ),
              ),
            ],
            child: MovieDetailScreen(movieID: movieId!),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  UserBloc(
                    myUserRepository: context
                        .read<AuthenticationBloc>()
                        .userRepository,
                  )..add(
                    GetMyUser(
                      userId: context
                          .read<AuthenticationBloc>()
                          .state
                          .user!
                          .uid,
                    ),
                  ),
            ),
            BlocProvider(
              create: (context) => SignInBloc(
                userRepository: context
                    .read<AuthenticationBloc>()
                    .userRepository,
              ),
            ),
            BlocProvider(
              create: (context) =>
                  UserBloc(
                    myUserRepository: context
                        .read<AuthenticationBloc>()
                        .userRepository,
                  )..add(
                    GetMyUser(
                      userId: context
                          .read<AuthenticationBloc>()
                          .state
                          .user!
                          .uid,
                    ),
                  ),
            ),
          ],
          child: LayoutScaffold(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => MultiBlocProvider(
                  providers: [
                    // BlocProvider(
                    //   create: (context) => UpdateUserInfoBloc(
                    //     userRepository: context
                    //         .read<AuthenticationBloc>()
                    //         .userRepository,
                    //   ),
                    // ),
                    BlocProvider(
                      create: (context) => GetNowPlayingBloc(
                        movieRepository: context.read<MovieRepository>(),
                      )..add(GetNowPlayingMovie()),
                    ),
                    BlocProvider(
                      create: (context) => GetTopRatedBloc(
                        movieRepository: context.read<MovieRepository>(),
                      )..add(GetTopRatedMovie()),
                    ),
                    BlocProvider(
                      create: (context) => GetPopularBloc(
                        movieRepository: context.read<MovieRepository>(),
                      )..add(GetPopularMovie()),
                    ),
                    BlocProvider(
                      create: (context) => GetTrendingDayBloc(
                        movieRepository: context.read<MovieRepository>(),
                      )..add(GetTrendingMovie()),
                    ),
                  ],
                  child: const HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.search,
                builder: (context, state) => BlocProvider(
                  create: (context) => SearchBloc(
                    movieRepository: context.read<MovieRepository>(),
                  ),
                  child: const SearchScreen(),
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.myMovies,
                builder: (context, state) => MultiBlocProvider(
                  providers: [
                    // BlocProvider(
                    //   create: (context) => UpdateUserInfoBloc(
                    //     userRepository: context
                    //         .read<AuthenticationBloc>()
                    //         .userRepository,
                    //   ),
                    // ),
                    BlocProvider(
                      create: (context) =>
                          UserBloc(
                            myUserRepository: context
                                .read<AuthenticationBloc>()
                                .userRepository,
                          )..add(
                            GetMyUser(
                              userId: context
                                  .read<AuthenticationBloc>()
                                  .state
                                  .user!
                                  .uid,
                            ),
                          ),
                    ),
                  ],
                  child: const MyMovieScreen(),
                ),
                routes: [
                  GoRoute(
                    path: Routes.setting,
                    builder: (context, state) => SettingScreen(),
                  ),
                ],

                // redirect: (context, state) {
                //   final authState = context.read<AuthenticationBloc>().state;

                //   // Nếu chưa đăng nhập, chuyển hướng sang /auth
                //   if (authState.status != AuthenticationStatus.authenticated) {
                //     return '/auth';
                //   }

                //   return null;
                // },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

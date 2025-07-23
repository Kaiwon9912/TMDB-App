import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_library/blocs/authentication/authentication_bloc.dart';
import 'package:movie_library/blocs/get_favorites/get_favorites_bloc.dart';
import 'package:movie_library/blocs/get_history/get_history_bloc.dart';

import 'package:movie_library/config/router/routes.dart';
import 'package:movie_library/screen/setting/favorites_movie_screen.dart';
import 'package:movie_library/screen/setting/history_screen.dart';
import 'package:my_movie_repository/my_movie_repsitory.dart';

class MyMovieScreen extends StatefulWidget {
  const MyMovieScreen({super.key});

  @override
  State<MyMovieScreen> createState() => _MyMovieScreenState();
}

class _MyMovieScreenState extends State<MyMovieScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                return IconButton(
                  onPressed: () {
                    context.push(Routes.nestedSetting);
                  },
                  icon: Icon(Icons.settings),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            final userId = context.read<AuthenticationBloc>().state.user!.uid;
            return Column(
              children: [
                TabBar(
                  indicator: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  controller: tabController,
                  tabs: const [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Favorites', style: TextStyle(fontSize: 16)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('History', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,

                    children: [
                      BlocProvider(
                        create: (context) => GetFavoritesBloc(
                          myMovieRepoistory: context.read<MyMovieRepository>(),
                        ),
                        child: FavoritesMovieScreen(userId: userId),
                      ),
                      BlocProvider(
                        create: (context) => GetHistoryBloc(
                          myMovieRepository: context.read<MyMovieRepository>(),
                        ),
                        child: HistoryScreen(userId: userId),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: GestureDetector(
                onTap: () {
                  context.go(Routes.auth);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.all(10),

                  child: Text('Login to continue'),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

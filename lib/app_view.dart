import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_library/blocs/authentication/authentication_bloc.dart';
import 'package:movie_library/config/router/app_router.dart';
import 'package:movie_library/config/theme/app_theme.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthenticationBloc>();

    return MaterialApp.router(
      routerConfig: createRouter(authBloc),
      debugShowCheckedModeBanner: false,
      title: 'Movie database',
      theme: darkMode,
    );
  }
}

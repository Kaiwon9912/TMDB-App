import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_library/blocs/authentication/authentication_bloc.dart';
import 'package:movie_library/blocs/sign_in/sign_in_bloc.dart';
import 'package:movie_library/blocs/sign_up/sign_up_bloc.dart';
import 'package:movie_library/config/router/routes.dart';
import 'package:movie_library/screen/authentication/sign_in_screen.dart';
import 'package:movie_library/screen/authentication/sign_up_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/loginscreen.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.6)),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 64),
                    const Text(
                      'The Movie Database',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: kToolbarHeight),
                    TabBar(
                      controller: tabController,
                      unselectedLabelColor: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withValues(alpha: 0.5),
                      labelColor: Theme.of(context).colorScheme.onPrimary,
                      tabs: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child:
                          BlocListener<AuthenticationBloc, AuthenticationState>(
                            listener: (context, state) {
                              if (state.status ==
                                  AuthenticationStatus.authenticated) {
                                context.go(Routes.home);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Đăng nhập thất bại')),
                                );
                              }
                            },
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                BlocProvider<SignInBloc>(
                                  create: (context) => SignInBloc(
                                    userRepository: context
                                        .read<AuthenticationBloc>()
                                        .userRepository,
                                  ),
                                  child: const SignInScreen(),
                                ),
                                BlocProvider<SignUpBloc>(
                                  create: (context) => SignUpBloc(
                                    userRepository: context
                                        .read<AuthenticationBloc>()
                                        .userRepository,
                                  ),
                                  child: const SignUpScreen(),
                                ),
                              ],
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

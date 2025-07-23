import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_library/app.dart';
import 'package:movie_library/bloc_observer.dart';
import 'package:movie_library/boxes.dart';
import 'package:movie_library/firebase_options.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MovieEntityAdapter());
  boxNowPlayingMovies = await Hive.openBox<MovieEntity>('nowPlayingMovies');
  boxTrendingMovies = await Hive.openBox<MovieEntity>('trendingMovies');
  boxPopularMovies = await Hive.openBox<MovieEntity>('popularMovies');
  boxTopRatedMovies = await Hive.openBox<MovieEntity>('topRatedMovies');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "movie_library",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MainApp(FirebaseUserRepository()));
}

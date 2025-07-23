import 'package:equatable/equatable.dart';

import 'package:my_movie_repository/src/models/my_movie_model.dart';

class MyMovie extends Equatable {
  final int id;
  final String title;
  final String overview;
  final double voteAverage;
  final String posterPath;
  final DateTime dateTime;

  const MyMovie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.dateTime,
    required this.voteAverage,
  });

  static final empty = MyMovie(
    id: 0,
    title: '',
    overview: '',
    posterPath: '',
    dateTime: DateTime.now(),
    voteAverage: 0,
  );

  MyMovie copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
    double? voteAverage,
  }) {
    return MyMovie(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      dateTime: dateTime,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  MyMovieModel toModel() {
    return MyMovieModel(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
      dateTime: dateTime,
    );
  }

  @override
  List<Object?> get props => [id, title, overview, posterPath];
}

import 'package:my_movie_repository/src/entities/my_movie.dart';

class MyMovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final DateTime dateTime;
  final double voteAverage;

  MyMovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.dateTime,
    required this.voteAverage,
  });

  MyMovie toEntity() {
    return MyMovie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
      dateTime: dateTime,
    );
  }

  factory MyMovieModel.fromEntity(MyMovie movie) {
    return MyMovieModel(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      voteAverage: movie.voteAverage,
      dateTime: movie.dateTime,
    );
  }
  MyMovieModel fromEntity() {
    return MyMovieModel(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      dateTime: dateTime,
      voteAverage: voteAverage,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'date_time': dateTime.toIso8601String(),
    };
  }

  factory MyMovieModel.fromDocument(Map<String, dynamic> doc) {
    return MyMovieModel(
      id: doc['id'],
      title: doc['title'] ?? '',
      overview: doc['overview'] ?? '',
      posterPath: doc['poster_path'] ?? '',
      voteAverage: (doc['vote_average'] as num?)?.toDouble() ?? 0.0,
      dateTime: DateTime.tryParse(doc['date_time'] ?? '') ?? DateTime.now(),
    );
  }
}

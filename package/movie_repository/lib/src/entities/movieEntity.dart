import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'movieEntity.g.dart';

@HiveType(typeId: 0)
class MovieEntity extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String overview;

  @HiveField(3)
  final String posterPath;

  @HiveField(4)
  final String backdropPath;

  @HiveField(5)
  final double voteAverage;

  @HiveField(6)
  final String releaseDate;

  @HiveField(7)
  final List<String>? genres;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    this.genres,
  });

  static const empty = MovieEntity(
    id: 0,
    title: '',
    overview: '',
    posterPath: '',
    backdropPath: '',
    voteAverage: 0.0,
    releaseDate: '',
    genres: [],
  );

  MovieEntity copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
    String? backdropPath,
    double? voteAverage,
    String? releaseDate,
  }) {
    return MovieEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteAverage: voteAverage ?? this.voteAverage,
      releaseDate: releaseDate ?? this.releaseDate,
      genres: genres,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    posterPath,
    backdropPath,
    voteAverage,
    releaseDate,
    genres,
  ];
}

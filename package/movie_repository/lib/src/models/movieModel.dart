import '../entities/movieEntity.dart';

class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final List<String>? genres;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final genresJson = json['genres'];
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'] ?? '',
      genres: genresJson is List
          ? genresJson.map((genre) => genre['name'].toString()).toList()
          : [],
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      genres: genres,
    );
  }

  static List<MovieEntity> toEntityList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => MovieModel.fromJson(json).toEntity())
        .toList();
  }

  static List<MovieModel> fromJsonList(List jsonList) {
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'genres': genres,
    };
  }

  factory MovieModel.fromDocument(Map<String, dynamic> doc) {
    return MovieModel(
      id: doc['id'],
      title: doc['title'] ?? '',
      overview: doc['overview'] ?? '',
      posterPath: doc['poster_path'] ?? '',
      backdropPath: doc['backdrop_path'] ?? '',
      voteAverage: (doc['vote_average'] as num).toDouble(),
      releaseDate: doc['release_date'] ?? '',
      genres: doc['genres'] != null ? List<String>.from(doc['genres']) : [],
    );
  }
}

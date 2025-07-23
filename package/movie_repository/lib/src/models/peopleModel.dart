import 'package:equatable/equatable.dart';
import 'package:movie_repository/movie_repository.dart';

class PeopleModel extends Equatable {
  final int id;
  final String name;
  final String? profilePath;
  final String? biography;
  final String? birthday;
  final String? placeOfBirth;
  final String? character;
  const PeopleModel({
    required this.id,
    required this.name,
    this.profilePath,
    this.biography,
    this.birthday,
    this.placeOfBirth,
    this.character,
  });

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      id: json['id'] as int,
      name: json['name'] as String,
      profilePath: json['profile_path'] as String?,
      biography: json['biography'] as String?,
      birthday: json['birthday'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      character: json['character'] ?? '',
    );
  }

  PeopleEntity toEntity() {
    return PeopleEntity(
      id: id,
      name: name,
      profilePath: profilePath,
      biography: biography,
      birthday: birthday,
      placeOfBirth: placeOfBirth,
    );
  }

  static List<PeopleEntity> toEntityList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => PeopleModel.fromJson(json).toEntity())
        .toList();
  }

  @override
  List<Object?> get props => [
    id,
    name,
    profilePath,
    biography,
    birthday,
    placeOfBirth,
    character,
  ];
}

class PeopleEntity {
  final int id;
  final String name;
  final String? profilePath;
  final String? knownForDepartment;
  final double? popularity;
  final String? biography;
  final String? birthday;
  final String? placeOfBirth;
  final String? gender;
  final String? character;
  PeopleEntity({
    required this.id,
    required this.name,
    this.profilePath,
    this.knownForDepartment,
    this.popularity,
    this.biography,
    this.birthday,
    this.placeOfBirth,
    this.gender,
    this.character,
  });
}

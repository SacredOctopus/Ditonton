import 'package:tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  const TvModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genresId,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.title,
  });

  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final String? firstAirDate;
  final List<String> originCountry;
  final List<int> genresId;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String title;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath: json["backdrop_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: json["first_air_date"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        genresId: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        voteCount: json["vote_count"],
        name: json["name"],
        title: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "popularity": popularity,
        "id": id,
        "backdrop_path": backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date": firstAirDate,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "genre_ids": List<dynamic>.from(genresId.map((x) => x)),
        "original_language": originalLanguage,
        "vote_count": voteCount,
        "name": name,
        "title": title,
      };

  Tv toEntity() {
    return Tv(
      posterPath: posterPath,
      popularity: popularity,
      id: id,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      overview: overview,
      firstAirDate: firstAirDate,
      originCountry: originCountry,
      genresId: genresId,
      originalLanguage: originalLanguage,
      voteCount: voteCount,
      name: name,
      title: title,
    );
  }

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genresId,
        originalLanguage,
        voteCount,
        name,
        title
      ];
}

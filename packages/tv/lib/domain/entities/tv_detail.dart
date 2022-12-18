import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  const TvDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.title,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String title;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        numberOfEpisodes,
        numberOfSeasons,
        title,
        overview,
        popularity,
        posterPath,
        status,
        voteAverage,
        voteCount
      ];
}

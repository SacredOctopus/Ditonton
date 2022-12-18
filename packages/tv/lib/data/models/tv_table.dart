import 'package:tv/data/models/tv_model.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  const TvTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory TvTable.fromEntity(TvDetail tv) => TvTable(
        id: tv.id,
        title: tv.title,
        posterPath: tv.posterPath,
        overview: tv.overview,
      );

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  factory TvTable.fromDTO(TvModel tv) => TvTable(
        id: tv.id,
        title: tv.title,
        posterPath: tv.posterPath,
        overview: tv.overview,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Tv toEntity() => Tv.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}

import 'package:tv_series/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonDetail extends Equatable {
  const SeasonDetail({
    required this.id,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonDetailId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? id;
  final List<Episode> episodes;
  final String? name;
  final String? overview;
  final int? seasonDetailId;
  final String? posterPath;
  final int? seasonNumber;

  @override
  List<Object?> get props => [
        id,
        episodes,
        name,
        overview,
        seasonDetailId,
        posterPath,
        seasonNumber,
      ];
}

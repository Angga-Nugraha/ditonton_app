import 'package:tv_series/data/models/episode_model.dart';
import 'package:tv_series/data/models/season_detail_model.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/domain/entities/season_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const seasonDetail = SeasonDetailModel(
      id: 'id',
      episodes: [
        EpisodeToAir(
            episodeNumber: 1,
            id: 1,
            name: 'name',
            overview: 'overview',
            productionCode: 'productionCode',
            runtime: 60,
            seasonNumber: 1,
            showId: 1,
            stillPath: 'stillPath',
            voteAverage: 1.0,
            voteCount: 1),
      ],
      name: 'name',
      overview: 'overview',
      seasonDetailId: 1,
      posterPath: 'posterPath',
      seasonNumber: 1);

  const season = SeasonDetail(
      id: 'id',
      episodes: [
        Episode(
            episodeNumber: 1,
            id: 1,
            name: 'name',
            overview: 'overview',
            productionCode: 'productionCode',
            runtime: 60,
            seasonNumber: 1,
            showId: 1,
            stillPath: 'stillPath',
            voteAverage: 1.0,
            voteCount: 1),
      ],
      name: 'name',
      overview: 'overview',
      seasonDetailId: 1,
      posterPath: 'posterPath',
      seasonNumber: 1);

  test('should be a subclass of TV Series entity', () async {
    final result = seasonDetail.toEntity();
    expect(result, season);
  });
}

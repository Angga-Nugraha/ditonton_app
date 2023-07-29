import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const seasonModel = SeasonModel(
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1);

  const season = Season(
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1);

  test('should be a Season of TV Series entity', () async {
    final result = seasonModel.toEntity();
    expect(result, season);
  });
}

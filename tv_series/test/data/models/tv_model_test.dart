import 'package:tv_series/data/models/tv_model.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tvModel = TvModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 10,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tv = Tv(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 10,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );
  test('should be a subclass of TV Series entity', () async {
    final result = tvModel.toEntity();
    expect(result, tv);
  });
}

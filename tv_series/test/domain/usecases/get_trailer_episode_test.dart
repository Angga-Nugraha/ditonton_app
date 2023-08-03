import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_trailer_episode.dart';

import '../../helpers/test_helper.mocks.dart';

final now = DateTime.now();

final kresultModel = ResultModel(
  iso6391: 'iso6391',
  iso31661: 'iso31661',
  name: 'name',
  key: 'key',
  publishedAt: now,
  site: 'site',
  size: 1,
  type: 'type',
  official: true,
  id: 'id',
);
final kVideoModel = VideoModel(id: 1, results: <ResultModel>[kresultModel]);

final kResult = Result(
  iso6391: 'iso6391',
  iso31661: 'iso31661',
  name: 'name',
  key: 'key',
  publishedAt: now,
  site: 'site',
  size: 1,
  type: 'type',
  official: true,
  id: 'id',
);

final kVideo = Video(id: 1, results: <Result>[kResult]);

void main() {
  late GetTrailerEpisode getTrailerEpisode;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getTrailerEpisode = GetTrailerEpisode(mockTvRepository);
  });

  test('should get episode video trailer', () async {
    // arrange
    when(mockTvRepository.getTrailerEpisode(1, 1, 1))
        .thenAnswer((_) async => Right(kVideo));
    // act
    final result = await getTrailerEpisode.execute(1, 1, 1);

    // assert
    expect(result, Right(kVideo));
  });
}

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_video_trailer_movie.dart';

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
  late GetTrailerMovie getTrailerMovie;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getTrailerMovie = GetTrailerMovie(movieRepository: mockMovieRepository);
  });

  test('should get video trailer', () async {
    // arrange
    when(mockMovieRepository.getTrailerMovies(1))
        .thenAnswer((_) async => Right(kVideo));
    // act
    final result = await getTrailerMovie.execute(1);

    // assert
    expect(result, Right(kVideo));
  });
}

import 'package:core/core.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_now_playing_on_air_tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:core/presentation/tv/provider/list_tv__notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TVListNotifier provider;
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    provider = TVListNotifier(
      getNowPlayingTV: mockGetNowPlayingTv,
      getPopularTV: mockGetPopularTv,
      getTopRatedTV: mockGetTopRatedTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tv = Tv(
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    originCountry: const ['originCountry'],
    name: 'name',
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tvList = <Tv>[tv];
  group('now playing TV Series', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tvList));
      // act
      provider.fetchNowPlayingOnAirTV();
      // assert
      verify(mockGetNowPlayingTv.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tvList));
      // act
      provider.fetchNowPlayingOnAirTV();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change TV Series when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(tvList));
      // act
      await provider.fetchNowPlayingOnAirTV();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingOnAirTV, tvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingOnAirTV();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular TV Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tvList));
      // act
      provider.fetchPopularTV();
      // assert
      expect(provider.popularTVState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change TV Series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tvList));
      // act
      await provider.fetchPopularTV();
      // assert
      expect(provider.popularTVState, RequestState.Loaded);
      expect(provider.popularTV, tvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTV();
      // assert
      expect(provider.popularTVState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated TV Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tvList));
      // act
      provider.fetchTopRatedTV();
      // assert
      expect(provider.topRatedTVState, RequestState.Loading);
    });

    test('should change TV Series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tvList));
      // act
      await provider.fetchTopRatedTV();
      // assert
      expect(provider.topRatedTVState, RequestState.Loaded);
      expect(provider.topRatedTV, tvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTV();
      // assert
      expect(provider.topRatedTVState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

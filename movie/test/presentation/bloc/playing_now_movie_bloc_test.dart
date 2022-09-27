import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/playing_now_movie_bloc.dart';

import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import '../../dummy_data/dummy_objects.dart';
import 'playing_now_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late PlayingNowMovieBloc playingNowMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    playingNowMovieBloc =
        PlayingNowMovieBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  group('Get Now Playing Movie', () {
    test('Initial state should be empty', () {
      expect(playingNowMovieBloc.state, PlayingNowMovieListEmpty());
    });

    blocTest<PlayingNowMovieBloc, PlayingNowMovieState>(
      'should get data movie from the usecase',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return playingNowMovieBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PlayingNowMovieListLoading(),
        PlayingNowMovieListHasData(result: tMovieList)
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  blocTest<PlayingNowMovieBloc, PlayingNowMovieState>(
    'Should emit error when get now playing unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return playingNowMovieBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PlayingNowMovieListLoading(),
      const PlayingNowMovieListError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}

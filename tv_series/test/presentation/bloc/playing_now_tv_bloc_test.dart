import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_now_playing_on_air_tv.dart';
import 'package:tv_series/presentation/bloc/playing_now_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'playing_now_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late PlayingNowTVBloc playingNowTVBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    playingNowTVBloc = PlayingNowTVBloc(mockGetNowPlayingTv);
  });

  group('Get Now Playing on air TV Series', () {
    test('Initial state should be empty', () {
      expect(playingNowTVBloc.state, PlayingNowTVEmpty());
    });

    blocTest<PlayingNowTVBloc, PlayingNowTVState>(
      'should get data movie from the usecase',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(testTVList));
        return playingNowTVBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTV()),
      wait: const Duration(milliseconds: 500),
      expect: () => [PlayingNowTVLoading(), PlayingNowTVHasData(testTVList)],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest<PlayingNowTVBloc, PlayingNowTVState>(
      'Should emit error when get now playing unsuccessful',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return playingNowTVBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTV()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PlayingNowTVLoading(),
        const PlayingNowTVError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetNowPlayingTv.execute()),
    );
  });
}

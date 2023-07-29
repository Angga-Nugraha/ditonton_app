import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTVBloc watchlistTVBloc;
  late MockGetWatchlistTv mockGetWatchlistTV;

  setUp(() {
    mockGetWatchlistTV = MockGetWatchlistTv();
    watchlistTVBloc = WatchlistTVBloc(getWatchlistTVs: mockGetWatchlistTV);
  });

  group('Get Watchlist TV', () {
    test('Initial state should be empty', () {
      expect(watchlistTVBloc.state, WatchlistTVEmpty());
    });

    blocTest<WatchlistTVBloc, WatchlistTVState>(
      'should get data TV from the usecase',
      build: () {
        when(mockGetWatchlistTV.execute())
            .thenAnswer((_) async => Right(testTVList));
        return watchlistTVBloc;
      },
      act: (bloc) => bloc.add(FetchTVWatchlist()),
      wait: const Duration(milliseconds: 500),
      expect: () => [WatchlistTVLoading(), WatchlistTVHasData(testTVList)],
      verify: (bloc) {
        verify(mockGetWatchlistTV.execute());
      },
    );

    blocTest<WatchlistTVBloc, WatchlistTVState>(
      'Should emit error when get watchlist unsuccessful',
      build: () {
        when(mockGetWatchlistTV.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTVBloc;
      },
      act: (bloc) => bloc.add(FetchTVWatchlist()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistTVLoading(),
        const WatchlistTVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTV.execute());
      },
    );
  });
}

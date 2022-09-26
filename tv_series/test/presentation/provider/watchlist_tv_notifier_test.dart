import 'package:core/core.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:core/presentation/tv/provider/watchlist_tv_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTVNotifier provider;
  late MockGetWatchlistTv mockGetWatchListTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchListTV = MockGetWatchlistTv();
    provider = WatchlistTVNotifier(
      getWatchlistTv: mockGetWatchListTV,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchListTV.execute())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTV();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 3);
  });
}

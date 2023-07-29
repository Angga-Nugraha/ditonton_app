import 'package:bloc_test/bloc_test.dart';
import 'package:core/watchlist/bloc/watchlist_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status.dart';
import 'package:tv_series/domain/usecases/remove_watchlist.dart';
import 'package:tv_series/domain/usecases/save_watchlist.dart';

import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  GetWatchListTVStatus,
  SaveWatchlist,
  SaveWatchlistTV,
  RemoveWatchlist,
  RemoveWatchlistTV
])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockGetWatchListTVStatus mockGetWatchListTVStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockSaveWatchlistTV mockSaveWatchlistTV;
  late MockRemoveWatchlist removeWatchlist;
  late MockRemoveWatchlistTV removeWatchlistTV;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockSaveWatchlistTV = MockSaveWatchlistTV();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockGetWatchListTVStatus = MockGetWatchListTVStatus();
    removeWatchlist = MockRemoveWatchlist();
    removeWatchlistTV = MockRemoveWatchlistTV();

    watchlistBloc = WatchlistBloc(
      getWatchListStatus: mockGetWatchListStatus,
      getWatchListTVStatus: mockGetWatchListTVStatus,
      removeWatchlist: removeWatchlist,
      removeWatchlistTV: removeWatchlistTV,
      saveWatchlist: mockSaveWatchlist,
      saveWatchlistTV: mockSaveWatchlistTV,
    );
  });

  const testMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );
  const tId = 1;
  // const tId = 1;
  // group('GetDetail Movie', () {
  test('Initial state should be false', () {
    expect(watchlistBloc.state, const WatchlistInitial(value: false));
  });

  blocTest<WatchlistBloc, WatchlistState>(
    'should Load watchlist status for movie',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => false);
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Add to watchlist'));
      return watchlistBloc;
    },
    act: (bloc) => [bloc.add(const LoadWatchlistStatus(tId))],
    wait: const Duration(milliseconds: 500),
    expect: () => [const WatchlistHasData(false)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );
}

import 'package:tv_series/data/datasources/tv_local_data_source.dart';
import 'package:tv_series/data/models/tv_table.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TVLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });
  const tesTvTable = TvTable(
    id: 1,
    name: null,
    posterPath: 'posterPath',
    overview: 'overview',
  );
  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.inserTvtWatchlist(testTVTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertTvWatchlist(testTVTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.inserTvtWatchlist(testTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertTvWatchlist(testTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTVTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeTvWatchlist(testTVTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeTvWatchlist(testTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Detail By Id', () {
    const tId = 1;

    test('should return TV Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTVMap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, tesTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist TV', () {
    test('should return list of TVTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTVMap]);
      // act
      final result = await dataSource.getWatchlistTv();
      // assert
      expect(result, [tesTvTable]);
    });
  });
}

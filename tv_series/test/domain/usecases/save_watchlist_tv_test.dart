import 'package:tv_series/domain/usecases/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTV usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = SaveWatchlistTV(mockTVRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockTVRepository.saveWatchlist(testTVDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.saveWatchlist(testTVDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}

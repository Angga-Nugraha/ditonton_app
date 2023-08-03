import 'package:tv_series/domain/usecases/remove_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTV usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = RemoveWatchlistTV(mockTVRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTVRepository.removeWatchlist(testTVDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.removeWatchlist(testTVDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}

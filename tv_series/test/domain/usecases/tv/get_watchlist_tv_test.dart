import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTv usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetWatchlistTv(mockTVRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTVRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTVList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVList));
  });
}

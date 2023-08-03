import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetTvDetail(mockTVRepository);
  });

  const tId = 1;

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockTVRepository.getTvDetail(tId))
        .thenAnswer((_) async => const Right(testTVDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, const Right(testTVDetail));
  });
}

import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_tv_recomendations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTVRepository);
  });

  const tId = 1;
  final tv = <Tv>[];

  test('should get list of movie recommendations from the repository',
      () async {
    // arrange
    when(mockTVRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tv));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tv));
  });
}

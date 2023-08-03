import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = GetTopRatedTv(mockTVRepository);
  });

  final tv = <Tv>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(mockTVRepository.getTopRatedTv()).thenAnswer((_) async => Right(tv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tv));
  });
}

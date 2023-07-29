import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

import 'search_tv_test.mocks.dart';

@GenerateMocks([SearchTv, TvRepository])
void main() {
  late SearchTv usecase;
  late MockTvRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTvRepository();
    usecase = SearchTv(mockTVRepository);
  });

  final tv = <Tv>[];
  const tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTVRepository.searchTv(tQuery)).thenAnswer((_) async => Right(tv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tv));
  });
}

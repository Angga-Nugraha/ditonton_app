import 'package:tv_series/domain/usecases/get_season_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonTV usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetSeasonTV(mockTvRepository);
  });

  const tId = 1;
  const tSeason = 1;

  test('Should get Season from TV Series from the repository', () async {
    when(mockTvRepository.getSeasonTv(tId, tSeason))
        .thenAnswer((_) async => const Right(seasonDetail));

    final result = await usecase.execute(tId, tSeason);
    // print(Right(seasonDetail));
    expect(result, const Right(seasonDetail));
  });
}

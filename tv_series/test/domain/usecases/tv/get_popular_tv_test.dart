import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockTVRpository;

  setUp(() {
    mockTVRpository = MockTvRepository();
    usecase = GetPopularTv(mockTVRpository);
  });

  final tv = <Tv>[];

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVRpository.getPopularTv()).thenAnswer((_) async => Right(tv));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tv));
      });
    });
  });
}

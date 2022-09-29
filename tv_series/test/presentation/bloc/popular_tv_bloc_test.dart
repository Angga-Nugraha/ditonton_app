import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late PopularTVBloc popularTVBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTVBloc = PopularTVBloc(mockGetPopularTv);
  });

  group('Get Popular TV Series', () {
    test('Initial state should be empty', () {
      expect(popularTVBloc.state, PopularTVEmpty());
    });

    blocTest<PopularTVBloc, PopularTVState>(
      'should get data movie from the usecase',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTVList));
        return popularTVBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTV()),
      wait: const Duration(milliseconds: 500),
      expect: () => [PopularTVLoading(), PopularTVHasData(testTVList)],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTVBloc, PopularTVState>(
      'Should emit error when get now playing unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularTVBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTV()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        PopularTVLoading(),
        const PopularTVError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularTv.execute()),
    );
  });
}

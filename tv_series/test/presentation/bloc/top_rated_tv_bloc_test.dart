import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTVBloc topRatedTVBloc;
  late MockGetTopRatedTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetTopRatedTv();
    topRatedTVBloc = TopRatedTVBloc(mockGetPopularTv);
  });

  group('Get Popular TV Series', () {
    test('Initial state should be empty', () {
      expect(topRatedTVBloc.state, TopRatedTVEmpty());
    });

    blocTest<TopRatedTVBloc, TopRatedTVState>(
      'should get data movie from the usecase',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTVList));
        return topRatedTVBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTV()),
      wait: const Duration(milliseconds: 500),
      expect: () => [TopRatedTVLoading(), TopRatedTVHasData(testTVList)],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<TopRatedTVBloc, TopRatedTVState>(
      'Should emit error when get now playing unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedTVBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTV()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedTVLoading(),
        const TopRatedTVError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularTv.execute()),
    );
  });
}

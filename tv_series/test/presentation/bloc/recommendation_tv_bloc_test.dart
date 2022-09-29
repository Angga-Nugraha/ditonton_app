import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_recomendations.dart';
import 'package:tv_series/presentation/bloc/recommendations_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late RecommendationTVBloc recommendationTVBloc;
  late MockGetTvRecommendations mockGetTVRecommendations;

  setUp(() {
    mockGetTVRecommendations = MockGetTvRecommendations();
    recommendationTVBloc =
        RecommendationTVBloc(getTVRecommendation: mockGetTVRecommendations);
  });

  const tId = 1;
  group('Get Recommendations TV', () {
    test('Initial state should be empty', () {
      expect(recommendationTVBloc.state, RecommendationTVEmpty());
    });

    blocTest<RecommendationTVBloc, RecommendationTVState>(
      'should get data recomendations TV from the usecase',
      build: () {
        when(mockGetTVRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTVList));
        return recommendationTVBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendationTV(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        RecommendationTVLoading(),
        RecommendationTVHasData(result: testTVList)
      ],
      verify: (bloc) {
        verify(mockGetTVRecommendations.execute(tId));
      },
    );

    blocTest<RecommendationTVBloc, RecommendationTVState>(
      'Should emit error when get recommendations unsuccessful',
      build: () {
        when(mockGetTVRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return recommendationTVBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendationTV(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        RecommendationTVLoading(),
        const RecommendationTVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTVRecommendations.execute(tId));
      },
    );
  });
}

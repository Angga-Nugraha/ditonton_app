import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/recommendation_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMovieBloc recommendationMovie;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovie = RecommendationMovieBloc(
        getMovieRecommendations: mockGetMovieRecommendations);
  });

  const tId = 1;
  group('Get Recommendations Movie', () {
    test('Initial state should be empty', () {
      expect(recommendationMovie.state, RecommendationMovieEmpty());
    });

    blocTest<RecommendationMovieBloc, RecommendationMovieState>(
      'should get data recomendations movie from the usecase',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));
        return recommendationMovie;
      },
      act: (bloc) => bloc.add(const FetchRecommendationMovie(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        RecommendationMovieLoading(),
        RecommendationMovieHasData(result: tMovieList)
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'Should emit error when get recommendations unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationMovie;
    },
    act: (bloc) => bloc.add(const FetchRecommendationMovie(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationMovieLoading(),
      const RecommendationMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc =
        TopRatedMovieBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  group('Get Top rated Movie', () {
    test('Initial state should be empty', () {
      expect(topRatedMovieBloc.state, TopRatedMovieListEmpty());
    });

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'should get Top rated movie from the usecase',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TopRatedMovieListLoading(),
        TopRatedMovieListHasData(result: tMovieList)
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit failure when get Top rated unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedMovieListLoading(),
      const TopRatedMovieListError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}

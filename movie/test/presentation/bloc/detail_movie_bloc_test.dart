import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/presentation/bloc/detail_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(getMovieDetail: mockGetMovieDetail);
  });

  const tId = 1;
  group('GetDetail Movie', () {
    test('Initial state should be empty', () {
      expect(detailMovieBloc.state, DetailMovieEmpty());
    });

    blocTest<DetailMovieBloc, DetailMovieState>(
      'should get detail movie from the usecase',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailMovie(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        DetailMovieLoading(),
        const DetailMovieHasData(result: testMovieDetail)
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit failure when get detail movie unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailMovie(tId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      DetailMovieLoading(),
      const DetailMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
}

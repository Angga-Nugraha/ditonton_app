import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late DetailTVBloc detailTVBloc;
  late MockGetTvDetail mockGetTVDetail;

  setUp(() {
    mockGetTVDetail = MockGetTvDetail();
    detailTVBloc = DetailTVBloc(getTVDetail: mockGetTVDetail);
  });

  const tId = 1;
  group('GetDetail TV', () {
    test('Initial state should be empty', () {
      expect(detailTVBloc.state, DetailTVEmpty());
    });

    blocTest<DetailTVBloc, DetailTVState>(
      'should get detail TV from the usecase',
      build: () {
        when(mockGetTVDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTVDetail));
        return detailTVBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailTV(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        DetailTVLoading(),
        const DetailTVHasData(result: testTVDetail),
      ],
      verify: (bloc) {
        verify(mockGetTVDetail.execute(tId));
      },
    );

    blocTest<DetailTVBloc, DetailTVState>(
      'Should emit failure when get detail TV unsuccessful',
      build: () {
        when(mockGetTVDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return detailTVBloc;
      },
      act: (bloc) => bloc.add(const FetchDetailTV(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        DetailTVLoading(),
        const DetailTVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTVDetail.execute(tId));
      },
    );
  });
}

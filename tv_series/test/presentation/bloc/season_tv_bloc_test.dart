import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_season_tv.dart';
import 'package:tv_series/presentation/bloc/season_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'season_tv_bloc_test.mocks.dart';

@GenerateMocks([GetSeasonTV])
void main() {
  late SeasonTVBloc seasonTVBloc;
  late MockGetSeasonTV mockGetSeasonTV;

  setUp(() {
    mockGetSeasonTV = MockGetSeasonTV();
    seasonTVBloc = SeasonTVBloc(getTVSeason: mockGetSeasonTV);
  });

  const tId = 1;
  const tNumSeason = 1;
  group('Get Season TV Detail', () {
    test('Initial state should be empty', () {
      expect(seasonTVBloc.state, SeasonTVEmpty());
    });

    blocTest<SeasonTVBloc, SeasonTVState>(
      'should get Season TV from the usecase',
      build: () {
        when(mockGetSeasonTV.execute(tId, tNumSeason))
            .thenAnswer((_) async => const Right(seasonDetail));
        return seasonTVBloc;
      },
      act: (bloc) => bloc.add(const FetchSeasonTV(tId, tNumSeason)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [SeasonTVLoading(), const SeasonTVHasData(result: seasonDetail)],
      verify: (bloc) {
        verify(mockGetSeasonTV.execute(tId, tNumSeason));
      },
    );

    blocTest<SeasonTVBloc, SeasonTVState>(
      'Should emit failure when get Season TV unsuccessful',
      build: () {
        when(mockGetSeasonTV.execute(tId, tNumSeason)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return seasonTVBloc;
      },
      act: (bloc) => bloc.add(const FetchSeasonTV(tId, tNumSeason)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SeasonTVLoading(),
        const SeasonTVError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetSeasonTV.execute(tId, tNumSeason));
      },
    );
  });
}

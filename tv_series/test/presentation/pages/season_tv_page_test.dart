import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/season_tv_bloc.dart';
import 'package:tv_series/presentation/pages/season_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSeasonTVBloc extends MockBloc<SeasonTVEvent, SeasonTVState>
    implements SeasonTVBloc {}

class SeasonTVEventFake extends Fake implements SeasonTVEvent {}

class SeasonTVStateFake extends Fake implements SeasonTVState {}

void main() {
  late MockSeasonTVBloc mockSeasonTVBloc;

  setUpAll(() {
    registerFallbackValue(SeasonTVEventFake());
    registerFallbackValue(SeasonTVStateFake());
  });

  setUp(() {
    mockSeasonTVBloc = MockSeasonTVBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SeasonTVBloc>(
      create: (context) => mockSeasonTVBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tId = 1;
  const tNumSeason = 1;
  group('Season TV Page', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(
        () => mockSeasonTVBloc.state,
      ).thenReturn(SeasonTVLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(
        makeTestableWidget(const SeasonTVPage(
          id: tId,
          numSeason: tNumSeason,
        )),
      );

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => mockSeasonTVBloc.state)
          .thenReturn(const SeasonTVHasData(result: seasonDetail));
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(
        makeTestableWidget(const SeasonTVPage(
          id: tId,
          numSeason: tNumSeason,
        )),
      );

      expect(listViewFinder, findsOneWidget);
    });
  });
}

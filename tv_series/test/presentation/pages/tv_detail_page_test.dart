import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/recommendations_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv_series/presentation/pages/detail_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

//=========================== detail TV =====================================
class MockDetailTVBloc extends MockBloc<DetailTVEvent, DetailTVState>
    implements DetailTVBloc {}

class DetailTVEventFake extends Fake implements DetailTVEvent {}

class DetailTVStateFake extends Fake implements DetailTVState {}

//============================ watchlist =======================================
class MockWatchlistBloc extends MockBloc<WatchlistEvent, WatchlistState>
    implements WatchlistBloc {}

class WatchlistEventFake extends Fake implements WatchlistEvent {}

class WatchlistStateFake extends Fake implements WatchlistState {}

//======================== recommendations TV ===============================
class MockRecommendationTVBloc
    extends MockBloc<RecommendationTVEvent, RecommendationTVState>
    implements RecommendationTVBloc {}

class RecommendationTVEventFake extends Fake implements RecommendationTVEvent {}

class RecommendationTVStateFake extends Fake implements RecommendationTVState {}

void main() {
  late MockDetailTVBloc mockDetailTVBloc;
  late MockWatchlistBloc mockWatchlistBloc;
  late MockRecommendationTVBloc recommendationTVBloc;

  setUpAll(() {
    registerFallbackValue(DetailTVEventFake());
    registerFallbackValue(DetailTVStateFake());
    registerFallbackValue(WatchlistEventFake());
    registerFallbackValue(WatchlistStateFake());
    registerFallbackValue(RecommendationTVEventFake());
    registerFallbackValue(RecommendationTVStateFake());
  });

  setUp(() {
    mockDetailTVBloc = MockDetailTVBloc();
    mockWatchlistBloc = MockWatchlistBloc();
    recommendationTVBloc = MockRecommendationTVBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTVBloc>(
          create: (context) => mockDetailTVBloc,
        ),
        BlocProvider<WatchlistBloc>(
          create: (context) => mockWatchlistBloc,
        ),
        BlocProvider<RecommendationTVBloc>(
          create: (context) => recommendationTVBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Detail TV Page', () {
    testWidgets(
        'Watchlist button should display add icon when TV not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockDetailTVBloc.state)
          .thenReturn(const DetailTVHasData(result: testTVDetail));
      when(() => recommendationTVBloc.state)
          .thenReturn(RecommendationTVHasData(result: testTVList));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistHasData(false));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when TV is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockDetailTVBloc.state)
          .thenReturn(const DetailTVHasData(result: testTVDetail));
      when(() => recommendationTVBloc.state)
          .thenReturn(RecommendationTVHasData(result: testTVList));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistHasData(true));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });
    testWidgets('Should text message  when error', (WidgetTester tester) async {
      when(() => mockDetailTVBloc.state)
          .thenReturn(const DetailTVError('error_message'));
      when(() => recommendationTVBloc.state)
          .thenReturn(const RecommendationTVError('error_message'));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistHasData(false));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

      expect(textFinder, findsOneWidget);
    });
  });
}

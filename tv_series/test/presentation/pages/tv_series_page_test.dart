import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';

//=========================== detail movie =====================================
class MockPlayingNowTVBloc
    extends MockBloc<PlayingNowTVEvent, PlayingNowTVState>
    implements PlayingNowTVBloc {}

class PlayingNowTVEventFake extends Fake implements PlayingNowTVEvent {}

class PlayingNowTVStateFake extends Fake implements PlayingNowTVState {}

//============================ watchlist =======================================
class MockTopRatedTVBloc extends MockBloc<TopRatedTVEvent, TopRatedTVState>
    implements TopRatedTVBloc {}

class TopRatedTVEventFake extends Fake implements TopRatedTVEvent {}

class TopRatedTVStateFake extends Fake implements TopRatedTVState {}

//======================== recommendations TV ===============================
class MockPopularTVBloc extends MockBloc<PopularTVEvent, PopularTVState>
    implements PopularTVBloc {}

class PopularTVEventFake extends Fake implements PopularTVEvent {}

class PopularTVStateFake extends Fake implements PopularTVState {}

void main() {
  late MockPlayingNowTVBloc mockPlayingNowTVBloc;
  late MockTopRatedTVBloc mockTopRatedBloc;
  late MockPopularTVBloc mockPopularTVBloc;

  setUpAll(() {
    registerFallbackValue(PlayingNowTVEventFake());
    registerFallbackValue(PlayingNowTVStateFake());
    registerFallbackValue(TopRatedTVEventFake());
    registerFallbackValue(TopRatedTVStateFake());
    registerFallbackValue(PopularTVEventFake());
    registerFallbackValue(PopularTVStateFake());
  });

  setUp(() {
    mockPlayingNowTVBloc = MockPlayingNowTVBloc();
    mockTopRatedBloc = MockTopRatedTVBloc();
    mockPopularTVBloc = MockPopularTVBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayingNowTVBloc>(
          create: (context) => mockPlayingNowTVBloc,
        ),
        BlocProvider<TopRatedTVBloc>(
          create: (context) => mockTopRatedBloc,
        ),
        BlocProvider<PopularTVBloc>(
          create: (context) => mockPopularTVBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Home TV Page', () {
    testWidgets(
        'Home TV page should display list of TV when TV added to, playing now, topRated, and popular',
        (WidgetTester tester) async {
      when(() => mockPlayingNowTVBloc.state)
          .thenReturn(PlayingNowTVHasData(testTVList));
      when(() => mockTopRatedBloc.state)
          .thenReturn(TopRatedTVHasData(testTVList));
      when(() => mockPopularTVBloc.state)
          .thenReturn(PopularTVHasData(testTVList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(TVList(testTVList)));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets(
        'Home TV page should display Loading circular indicator when load the data',
        (WidgetTester tester) async {
      when(() => mockPlayingNowTVBloc.state).thenReturn(PlayingNowTVLoading());
      when(() => mockTopRatedBloc.state).thenReturn(TopRatedTVLoading());
      when(() => mockPopularTVBloc.state).thenReturn(PopularTVLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(TVList(testTVList)));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });
  });
}

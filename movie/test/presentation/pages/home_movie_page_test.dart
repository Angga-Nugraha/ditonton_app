import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

//=========================== detail movie =====================================
class MockPlayingNowMovieBloc
    extends MockBloc<PlayingNowMovieEvent, PlayingNowMovieState>
    implements PlayingNowMovieBloc {}

class PlayingNowMovieEventFake extends Fake implements PlayingNowMovieEvent {}

class PlayingNowMovieStateFake extends Fake implements PlayingNowMovieState {}

//============================ watchlist =======================================
class MockTopRatedMovieBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

class TopRatedEventFake extends Fake implements TopRatedMovieEvent {}

class TopRatedStateFake extends Fake implements TopRatedMovieState {}

//======================== recommendations movie ===============================
class MockPopularMovieBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

class PopularMovieEventFake extends Fake implements PopularMovieEvent {}

class PopularMovieStateFake extends Fake implements PopularMovieState {}

void main() {
  late MockPlayingNowMovieBloc mockPlayingNowMovieBloc;
  late MockTopRatedMovieBloc mockTopRatedBloc;
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUpAll(() {
    registerFallbackValue(PlayingNowMovieEventFake());
    registerFallbackValue(PlayingNowMovieStateFake());
    registerFallbackValue(TopRatedEventFake());
    registerFallbackValue(TopRatedStateFake());
    registerFallbackValue(PopularMovieEventFake());
    registerFallbackValue(PopularMovieStateFake());
  });

  setUp(() {
    mockPlayingNowMovieBloc = MockPlayingNowMovieBloc();
    mockTopRatedBloc = MockTopRatedMovieBloc();
    mockPopularMovieBloc = MockPopularMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayingNowMovieBloc>(
          create: (context) => mockPlayingNowMovieBloc,
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (context) => mockTopRatedBloc,
        ),
        BlocProvider<PopularMovieBloc>(
          create: (context) => mockPopularMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Home Movie Page', () {
    testWidgets(
        'Home movie page should display list of movie when movie added to, playing now, topRated, and popular',
        (WidgetTester tester) async {
      when(() => mockPlayingNowMovieBloc.state)
          .thenReturn(PlayingNowMovieListHasData(result: tMovieList));
      when(() => mockTopRatedBloc.state)
          .thenReturn(TopRatedMovieListHasData(result: tMovieList));
      when(() => mockPopularMovieBloc.state)
          .thenReturn(PopularMovieHasData(result: tMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(MovieList(tMovieList)));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets(
        'Home movie page should display Loading circular indicator when load the data',
        (WidgetTester tester) async {
      when(() => mockPlayingNowMovieBloc.state)
          .thenReturn(PlayingNowMovieListLoading());
      when(() => mockTopRatedBloc.state).thenReturn(TopRatedMovieListLoading());
      when(() => mockPopularMovieBloc.state).thenReturn(PopularMovieLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(MovieList(tMovieList)));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/detail_movie_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

//=========================== detail movie =====================================
class MockDetailMovieBloc extends MockBloc<DetailMovieEvent, DetailMovieState>
    implements DetailMovieBloc {}

class DetailMovieEventFake extends Fake implements DetailMovieEvent {}

class DetailMovieStateFake extends Fake implements DetailMovieState {}

//============================ watchlist =======================================
class MockWatchlistBloc extends MockBloc<WatchlistEvent, WatchlistState>
    implements WatchlistBloc {}

class WatchlistEventFake extends Fake implements WatchlistEvent {}

class WatchlistStateFake extends Fake implements WatchlistState {}

//======================== recommendations movie ===============================
class MockRecommendationMovieBloc
    extends MockBloc<RecommendationMovieEvent, RecommendationMovieState>
    implements RecommendationMovieBloc {}

class RecommendationMovieEventFake extends Fake
    implements RecommendationMovieEvent {}

class RecommendationMovieStateFake extends Fake
    implements RecommendationMovieState {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late MockDetailMovieBloc mockDetailMovieBloc;
  late MockWatchlistBloc mockWatchlistBloc;
  late MockRecommendationMovieBloc recommendationMovieBloc;

  setUpAll(() {
    registerFallbackValue(DetailMovieEventFake());
    registerFallbackValue(DetailMovieStateFake());
    registerFallbackValue(WatchlistEventFake());
    registerFallbackValue(WatchlistStateFake());
    registerFallbackValue(RecommendationMovieEventFake());
    registerFallbackValue(RecommendationMovieStateFake());
  });

  setUp(() {
    mockDetailMovieBloc = MockDetailMovieBloc();
    mockWatchlistBloc = MockWatchlistBloc();
    recommendationMovieBloc = MockRecommendationMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(
          create: (context) => mockDetailMovieBloc,
        ),
        BlocProvider<WatchlistBloc>(
          create: (context) => mockWatchlistBloc,
        ),
        BlocProvider<RecommendationMovieBloc>(
          create: (context) => recommendationMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Detail Movie Page', () {
    testWidgets('Should progres indicator bar when data loading',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state).thenReturn(DetailMovieLoading());
      when(() => recommendationMovieBloc.state)
          .thenReturn(RecommendationMovieLoading());
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistHasData(false));

      final finderProgresBar = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(finderProgresBar, findsOneWidget);
      expect(centerFinder, findsOneWidget);
    });
    testWidgets('Should text message  when error', (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(const DetailMovieError('error_message'));
      when(() => recommendationMovieBloc.state)
          .thenReturn(const RecommendationMovieError('error_message'));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistHasData(false));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(textFinder, findsOneWidget);
    });
    testWidgets(
        'Watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(const DetailMovieHasData(result: testMovieDetail));
      when(() => recommendationMovieBloc.state)
          .thenReturn(RecommendationMovieHasData(result: tMovieList));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistHasData(false));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when movie is added to wathclist',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(const DetailMovieHasData(result: testMovieDetail));
      when(() => recommendationMovieBloc.state)
          .thenReturn(RecommendationMovieHasData(result: tMovieList));
      when(() => mockWatchlistBloc.state)
          .thenReturn(const WatchlistHasData(true));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:tv_series/presentation/widgets/watchlist_tv.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistTVBloc extends MockBloc<WatchlistTVEvent, WatchlistTVState>
    implements WatchlistTVBloc {}

class WatchlistTVEventFake extends Fake implements WatchlistTVEvent {}

class WatchlistTVStateFake extends Fake implements WatchlistTVState {}

void main() {
  late MockWatchlistTVBloc mockWatchlistTVBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistTVEventFake());
    registerFallbackValue(WatchlistTVStateFake());
  });

  setUp(() {
    mockWatchlistTVBloc = MockWatchlistTVBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTVBloc>(
      create: (context) => mockWatchlistTVBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Watchlist TV Page', () {
    testWidgets('Page should display progress bar when loading',
        (WidgetTester tester) async {
      when(
        () => mockWatchlistTVBloc.state,
      ).thenReturn(WatchlistTVLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const WatchListTV()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (WidgetTester tester) async {
      when(() => mockWatchlistTVBloc.state)
          .thenReturn(WatchlistTVHasData(testTVList));
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const WatchListTV()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockWatchlistTVBloc.state)
          .thenReturn(const WatchlistTVError('Failed'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const WatchListTV()));

      expect(textFinder, findsOneWidget);
    });
  });
}

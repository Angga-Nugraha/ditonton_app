import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularTVBloc extends MockBloc<PopularTVEvent, PopularTVState>
    implements PopularTVBloc {}

class PopularTVEventFake extends Fake implements PopularTVEvent {}

class PopularTVStateFake extends Fake implements PopularTVState {}

void main() {
  late MockPopularTVBloc mockPopularTVBloc;

  setUpAll(() {
    registerFallbackValue(PopularTVEventFake());
    registerFallbackValue(PopularTVStateFake());
  });

  setUp(() {
    mockPopularTVBloc = MockPopularTVBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVBloc>(
      create: (context) => mockPopularTVBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Popular TV Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockPopularTVBloc.state).thenReturn(PopularTVLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockPopularTVBloc.state)
          .thenReturn(PopularTVHasData(testTVList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockPopularTVBloc.state)
          .thenReturn(const PopularTVError('Failed'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));
      expect(textFinder, findsOneWidget);
    });
  });
}

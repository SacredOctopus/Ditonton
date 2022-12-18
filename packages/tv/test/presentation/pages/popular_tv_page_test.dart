import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularTvBloc extends MockBloc<TvEvent, TvState>
    implements PopularTvBloc {}

class TvStateFake extends Fake implements TvState {}

class TvEventFake extends Fake implements TvEvent {}

void main() {
  late MockPopularTvBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());
  });

  setUp(() {
    mockBloc = MockPopularTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(Loading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadedData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should not display progressbar and listview when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const Error('Error message'));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });

  testWidgets('Page should not display progressbar and listview when Empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(EmptyData());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });
}

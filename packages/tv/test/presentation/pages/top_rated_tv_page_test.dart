import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTvBloc extends MockBloc<TvEvent, TvState>
    implements TopRatedTvBloc {}

class TvStateFake extends Fake implements TvState {}

class TvEventFake extends Fake implements TvEvent {}

void main() {
  late MockTopRatedTvBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());
  });

  setUp(() {
    mockBloc = MockTopRatedTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(Loading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadedData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should not display progressbar and listview when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const Error('Error message'));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });

  testWidgets('Page should not display progressbar and listview when Empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(EmptyData());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements TopRatedMovieBloc {}

class MovieStateFake extends Fake implements MovieState {}

class MovieEventFake extends Fake implements MovieEvent {}

void main() {
  late MockTopRatedMovieBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  setUp(() {
    mockBloc = MockTopRatedMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>.value(
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

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadedData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should not display progressbar and listview when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const Error('Error message'));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });

  testWidgets('Page should not display progressbar and listview when Empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(EmptyData());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(progressBarFinder, findsNothing);
    expect(listViewFinder, findsNothing);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie/presentation/bloc/moviedetail/moviedetail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieStateFake extends Fake implements MovieDetailState {}

class MovieEventFake extends Fake implements MovieEvent {}

class MockRecommendationMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements RecommendationMoviesBloc {}

void main() {
  late MockMovieDetailBloc mockBloc;
  late MockRecommendationMovieBloc mockBlocRecom;

  setUpAll(() {
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  setUp(() {
    mockBloc = MockMovieDetailBloc();
    mockBlocRecom = MockRecommendationMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(value: mockBloc),
        BlocProvider<RecommendationMoviesBloc>.value(value: mockBlocRecom),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(' Page should display Progressbar when Moviedetail loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
        MovieDetailState.initial().copyWith(state: RequestState.loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(' Page should display Progressbar when recommendation loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      state: RequestState.loaded,
      isAddedToWatchlist: false,
      movieDetail: testMovieDetail,
    ));
    when(() => mockBlocRecom.state).thenReturn(Loading());

    final progressBarFinder = find.byType(CircularProgressIndicator).first;

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when Tv Show not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      state: RequestState.loaded,
      isAddedToWatchlist: false,
      movieDetail: testMovieDetail,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadedData(testMovieList));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when Movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      state: RequestState.loaded,
      movieDetail: testMovieDetail,
      isAddedToWatchlist: true,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadedData(testMovieList));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}

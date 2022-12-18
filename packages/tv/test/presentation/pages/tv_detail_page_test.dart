import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';
import 'package:tv/presentation/bloc/tvdetail/tvdetail_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class TvStateFake extends Fake implements TvDetailState {}

class TvEventFake extends Fake implements TvEvent {}

class MockRecommendationTvBloc extends MockBloc<TvEvent, TvState>
    implements RecommendationTvBloc {}

void main() {
  late MockTvDetailBloc mockBloc;
  late MockRecommendationTvBloc mockBlocRecom;

  setUpAll(() {
    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());
  });

  setUp(() {
    mockBloc = MockTvDetailBloc();
    mockBlocRecom = MockRecommendationTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>.value(value: mockBloc),
        BlocProvider<RecommendationTvBloc>.value(value: mockBlocRecom),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(' Page should display Progressbar when tvdetail loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
        TvDetailState.initial().copyWith(state: RequestState.loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(' Page should display Progressbar when recommendation loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvDetailState.initial().copyWith(
      state: RequestState.loaded,
      isAddedToWatchlist: false,
      tvDetail: testTvDetail,
    ));
    when(() => mockBlocRecom.state).thenReturn(Loading());

    final progressBarFinder = find.byType(CircularProgressIndicator).first;

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when Tv Show not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvDetailState.initial().copyWith(
      state: RequestState.loaded,
      isAddedToWatchlist: false,
      tvDetail: testTvDetail,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadedData(testTvList));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when Tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvDetailState.initial().copyWith(
      state: RequestState.loaded,
      tvDetail: testTvDetail,
      isAddedToWatchlist: true,
    ));
    when(() => mockBlocRecom.state).thenReturn(LoadedData(testTvList));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}

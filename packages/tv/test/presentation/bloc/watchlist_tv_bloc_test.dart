import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late WatchlistTvBloc watchlistBloc;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    watchlistBloc = WatchlistTvBloc(mockGetWatchlistTv);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, EmptyData());
  });

  blocTest<WatchlistTvBloc, TvState>(
    'emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      LoadedData([testWatchlistTv]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<WatchlistTvBloc, TvState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<WatchlistTvBloc, TvState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      const Error('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<WatchlistTvBloc, TvState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      const Error('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );
}

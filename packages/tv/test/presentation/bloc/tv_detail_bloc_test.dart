import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/tvdetail/tvdetail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailBloc detailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetWatchListStatusTv mockGetWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetWatchlistStatus = MockGetWatchListStatusTv();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    detailBloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  group('Get Tv Detail', () {
    test('initial state should be empty', () {
      expect(detailBloc.state.state, RequestState.empty);
    });

    blocTest<TvDetailBloc, TvDetailState>(
      'emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTvDetail));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const TvDetailDataWithIdEvent(tId)),
      expect: () => [
        TvDetailState.initial().copyWith(state: RequestState.loading),
        TvDetailState.initial().copyWith(
          state: RequestState.loaded,
          tvDetail: testTvDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'emit [Loading, Error] when get top rated is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const TvDetailDataWithIdEvent(tId)),
      expect: () => [
        TvDetailState.initial().copyWith(state: RequestState.loading),
        TvDetailState.initial().copyWith(
          state: RequestState.error,
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
      },
    );
  });

  group('Watchlist Status', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Get Watchlist Status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatusEvent(tId)),
      expect: () => [
        TvDetailState.initial().copyWith(
          tvDetail: testTvDetail,
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistEvent(testTvDetail)),
      expect: () => [
        TvDetailState.initial().copyWith(
            tvDetail: testTvDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Success'),
        TvDetailState.initial().copyWith(
            tvDetail: testTvDetail,
            isAddedToWatchlist: true,
            watchlistMessage: 'Success'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTvDetail));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlistEvent(testTvDetail)),
      expect: () => [
        TvDetailState.initial().copyWith(
            tvDetail: testTvDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testTvDetail));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'update watchlist message when add watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testTvDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistEvent(testTvDetail)),
      expect: () => [
        TvDetailState.initial().copyWith(
            tvDetail: testTvDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testTvDetail));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'update watchlist message when remove watchlist failed',
      build: () {
        when(mockRemoveWatchlist.execute(testTvDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlistEvent(testTvDetail)),
      expect: () => [
        TvDetailState.initial().copyWith(
            tvDetail: testTvDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testTvDetail));
      },
    );
  });
}

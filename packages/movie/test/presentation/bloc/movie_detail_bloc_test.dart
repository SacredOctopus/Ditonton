import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_status_movie.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:movie/presentation/bloc/moviedetail/moviedetail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetWatchListStatusMovie,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
])
void main() {
  late MovieDetailBloc detailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatusMovie mockGetWatchlistStatus;
  late MockSaveWatchlistMovie mockSaveWatchlist;
  late MockRemoveWatchlistMovie mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchlistStatus = MockGetWatchListStatusMovie();
    mockSaveWatchlist = MockSaveWatchlistMovie();
    mockRemoveWatchlist = MockRemoveWatchlistMovie();
    detailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  group('Get Movie Detail', () {
    test('initial state should be empty', () {
      expect(detailBloc.state.state, RequestState.empty);
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const MovieDetailDataWithIdEvent(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(state: RequestState.loading),
        MovieDetailState.initial().copyWith(
          state: RequestState.loaded,
          movieDetail: testMovieDetail,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emit [Loading, Error] when get top rated is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const MovieDetailDataWithIdEvent(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(state: RequestState.loading),
        MovieDetailState.initial().copyWith(
          state: RequestState.error,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Watchlist Status', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Get Watchlist Status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatusEvent(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetail: testMovieDetail,
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistEvent(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Success'),
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: true,
            watchlistMessage: 'Success'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlistEvent(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Removed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'update watchlist message when add watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistEvent(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'update watchlist message when remove watchlist failed',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlistEvent(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
            movieDetail: testMovieDetail,
            isAddedToWatchlist: false,
            watchlistMessage: 'Server Failure'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
  });
}

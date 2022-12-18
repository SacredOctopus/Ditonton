import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovie;
  late WatchlistMovieBloc watchlistBloc;

  setUp(() {
    mockGetWatchlistMovie = MockGetWatchlistMovies();
    watchlistBloc = WatchlistMovieBloc(mockGetWatchlistMovie);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, EmptyData());
  });

  blocTest<WatchlistMovieBloc, MovieState>(
    'emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      LoadedData([testWatchlistMovie]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );

  blocTest<WatchlistMovieBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );

  blocTest<WatchlistMovieBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistMovie.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );

  blocTest<WatchlistMovieBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetWatchlistMovie.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovie.execute());
    },
  );
}

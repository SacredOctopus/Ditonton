import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieBloc moviesBloc;

  setUp(
    () {
      mockGetNowPlayingMovies = MockGetNowPlayingMovies();
      moviesBloc = MovieBloc(mockGetNowPlayingMovies);
    },
  );

  test('initial state should be empty', () {
    expect(moviesBloc.state, EmptyData());
  });

  blocTest<MovieBloc, MovieState>(
    'emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      LoadedData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}

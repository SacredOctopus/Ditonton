import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc popularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('initial state should be empty', () {
    expect(popularBloc.state, EmptyData());
  });

  blocTest<PopularMovieBloc, MovieState>(
    'emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      LoadedData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMovieBloc, MovieState>(
    'emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMovieBloc, MovieState>(
    'emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMovieBloc, MovieState>(
    'emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}

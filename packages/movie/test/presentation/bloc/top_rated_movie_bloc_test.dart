import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovie;
  late TopRatedMovieBloc topRatedBloc;

  setUp(() {
    mockGetTopRatedMovie = MockGetTopRatedMovies();
    topRatedBloc = TopRatedMovieBloc(mockGetTopRatedMovie);
  });

  test('initial state should be empty', () {
    expect(topRatedBloc.state, EmptyData());
  });

  blocTest<TopRatedMovieBloc, MovieState>(
    'emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovie.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      LoadedData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );

  blocTest<TopRatedMovieBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedMovie.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );

  blocTest<TopRatedMovieBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedMovie.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );

  blocTest<TopRatedMovieBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedMovie.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const MoviesDataEvent()),
    expect: () => [
      Loading(),
      const Error('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetRecommendationMovie;
  late RecommendationMoviesBloc recomBloc;

  setUp(() {
    mockGetRecommendationMovie = MockGetMovieRecommendations();
    recomBloc = RecommendationMoviesBloc(mockGetRecommendationMovie);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(recomBloc.state, EmptyData());
  });

  blocTest<RecommendationMoviesBloc, MovieState>(
    'emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationMovie.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const MovieDataWithIdEvent(tId)),
    expect: () => [
      Loading(),
      LoadedData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovie.execute(tId));
    },
  );

  blocTest<RecommendationMoviesBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetRecommendationMovie.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const MovieDataWithIdEvent(tId)),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovie.execute(tId));
    },
  );

  blocTest<RecommendationMoviesBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetRecommendationMovie.execute(tId)).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const MovieDataWithIdEvent(tId)),
    expect: () => [
      Loading(),
      const Error('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovie.execute(tId));
    },
  );

  blocTest<RecommendationMoviesBloc, MovieState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetRecommendationMovie.execute(tId)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const MovieDataWithIdEvent(tId)),
    expect: () => [
      Loading(),
      const Error('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovie.execute(tId));
    },
  );
}

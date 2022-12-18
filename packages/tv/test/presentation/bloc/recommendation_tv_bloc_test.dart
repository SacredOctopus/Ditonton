import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late MockGetTvRecommendations mockGetRecommendationTv;
  late RecommendationTvBloc recomBloc;

  setUp(() {
    mockGetRecommendationTv = MockGetTvRecommendations();
    recomBloc = RecommendationTvBloc(mockGetRecommendationTv);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(recomBloc.state, EmptyData());
  });

  blocTest<RecommendationTvBloc, TvState>(
    'emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationTv.execute(tId))
          .thenAnswer((_) async => Right(testTvList));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const TvDataWithIdEvent(tId)),
    expect: () => [
      Loading(),
      LoadedData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTv.execute(tId));
    },
  );

  blocTest<RecommendationTvBloc, TvState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetRecommendationTv.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const TvDataWithIdEvent(tId)),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTv.execute(tId));
    },
  );

  blocTest<RecommendationTvBloc, TvState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetRecommendationTv.execute(tId)).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const TvDataWithIdEvent(tId)),
    expect: () => [
      Loading(),
      const Error('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTv.execute(tId));
    },
  );

  blocTest<RecommendationTvBloc, TvState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetRecommendationTv.execute(tId)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return recomBloc;
    },
    act: (bloc) => bloc.add(const TvDataWithIdEvent(tId)),
    expect: () => [
      Loading(),
      const Error('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTv.execute(tId));
    },
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc popularBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularBloc = PopularTvBloc(mockGetPopularTv);
  });

  test('initial state should be empty', () {
    expect(popularBloc.state, EmptyData());
  });

  blocTest<PopularTvBloc, TvState>(
    'emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      LoadedData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );

  blocTest<PopularTvBloc, TvState>(
    'emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );

  blocTest<PopularTvBloc, TvState>(
    'emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      const Error('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );

  blocTest<PopularTvBloc, TvState>(
    'emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return popularBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      const Error('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvBloc topRatedBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('initial state should be empty', () {
    expect(topRatedBloc.state, EmptyData());
  });

  blocTest<TopRatedTvBloc, TvState>(
    'emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      LoadedData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );

  blocTest<TopRatedTvBloc, TvState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );

  blocTest<TopRatedTvBloc, TvState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer(
          (_) async => const Left(ConnectionFailure('Connection Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      const Error('Connection Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );

  blocTest<TopRatedTvBloc, TvState>(
    'emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(const TvDataEvent()),
    expect: () => [
      Loading(),
      const Error('Database Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/presentation/bloc/search/search_tv_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/search_tv.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchBloc = SearchTvBloc(mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  final tTv = Tv(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: const ["US"],
    genresId: const [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    title: "Pretty Little Liars",
  );
  final tTvList = <Tv>[tTv];
  const tQuery = 'Pretty Little Liars';

  blocTest<SearchTvBloc, SearchTvState>(
    'emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      SearchHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      const Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );
}

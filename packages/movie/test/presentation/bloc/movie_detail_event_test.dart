import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/moviedetail/moviedetail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([1], const MovieDetailDataWithIdEvent(1).props);
    expect([testMovieDetail], const AddWatchlistEvent(testMovieDetail).props);
    expect(
        [testMovieDetail], const RemoveWatchlistEvent(testMovieDetail).props);
    expect([1], const LoadWatchlistStatusEvent(1).props);
  });
}

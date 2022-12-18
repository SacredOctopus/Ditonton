import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/bloc/tvdetail/tvdetail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([1], const TvDetailDataWithIdEvent(1).props);
    expect([testTvDetail], const AddWatchlistEvent(testTvDetail).props);
    expect([testTvDetail], const RemoveWatchlistEvent(testTvDetail).props);
    expect([1], const LoadWatchlistStatusEvent(1).props);
  });
}

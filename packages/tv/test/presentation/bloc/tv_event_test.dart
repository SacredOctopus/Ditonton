import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([], const TvDataEvent().props);
    expect([1], const TvDataWithIdEvent(1).props);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';

void main() {
  test('Cek if props same with the input', () {
    expect([], const MoviesDataEvent().props);
    expect([1], const MovieDataWithIdEvent(1).props);
  });
}

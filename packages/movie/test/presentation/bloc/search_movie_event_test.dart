import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/search/search_movie_bloc.dart';

void main() {
  test('Cek if props same with the input', () {
    expect(['Test'], const OnQueryChangedEvent('Test').props);
  });
}
